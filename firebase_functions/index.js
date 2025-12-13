/**
 * Firebase Cloud Functions for Tinseltown IQ Stripe Payments
 * 
 * SETUP INSTRUCTIONS:
 * 1. Install Firebase CLI: npm install -g firebase-tools
 * 2. Login to Firebase: firebase login
 * 3. Initialize functions: firebase init functions
 * 4. Copy this file to functions/index.js
 * 5. Set Stripe secret key: firebase functions:config:set stripe.secret="sk_test_YOUR_SECRET_KEY"
 * 6. Set webhook secret: firebase functions:config:set stripe.webhook_secret="whsec_YOUR_WEBHOOK_SECRET"
 * 7. Deploy: firebase deploy --only functions
 */

const functions = require('firebase-functions');
const admin = require('firebase-admin');

// Initialize Firebase Admin
admin.initializeApp();

// Initialize Stripe with secret key from Firebase config
const stripe = require('stripe')(functions.config().stripe.secret);

// Firestore database reference
const db = admin.firestore();

// ═══════════════════════════════════════════════════════════════
// CREATE PAYMENT INTENT - Called from Flutter app
// ═══════════════════════════════════════════════════════════════

/**
 * Creates a Stripe PaymentIntent for subscription upgrade
 * Called via HTTP POST from Flutter app
 */
exports.createPaymentIntent = functions.https.onRequest(async (req, res) => {
  // Enable CORS
  res.set('Access-Control-Allow-Origin', '*');
  res.set('Access-Control-Allow-Methods', 'POST, OPTIONS');
  res.set('Access-Control-Allow-Headers', 'Content-Type, Authorization');

  // Handle preflight OPTIONS request
  if (req.method === 'OPTIONS') {
    res.status(204).send('');
    return;
  }

  // Only allow POST
  if (req.method !== 'POST') {
    res.status(405).json({ error: 'Method not allowed' });
    return;
  }

  try {
    const { amount, currency, plan_id, user_id, user_email, metadata } = req.body;

    // Validate required fields
    if (!amount || !plan_id || !user_id) {
      res.status(400).json({ error: 'Missing required fields: amount, plan_id, user_id' });
      return;
    }

    // Create PaymentIntent
    const paymentIntent = await stripe.paymentIntents.create({
      amount: amount, // Amount in cents
      currency: currency || 'usd',
      automatic_payment_methods: {
        enabled: true,
      },
      metadata: {
        app: 'tinseltown_iq',
        plan_id: plan_id,
        user_id: user_id,
        user_email: user_email || '',
        ...metadata,
      },
      receipt_email: user_email,
      description: `Tinseltown IQ - ${plan_id} Plan Subscription`,
    });

    // Log the payment intent creation
    console.log(`PaymentIntent created: ${paymentIntent.id} for user ${user_id}, plan ${plan_id}`);

    // Return client secret to app
    res.json({
      clientSecret: paymentIntent.client_secret,
      paymentIntentId: paymentIntent.id,
    });

  } catch (error) {
    console.error('Error creating PaymentIntent:', error);
    res.status(500).json({ error: error.message });
  }
});

// ═══════════════════════════════════════════════════════════════
// CREATE PAYMENT INTENT - Callable version (with auth)
// ═══════════════════════════════════════════════════════════════

/**
 * Creates a Stripe PaymentIntent (authenticated callable function)
 * Requires user to be logged in via Firebase Auth
 */
exports.createPaymentIntentAuth = functions.https.onCall(async (data, context) => {
  // Verify user is authenticated
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'User must be logged in to make a payment'
    );
  }

  const { amount, plan_id } = data;
  const user_id = context.auth.uid;
  const user_email = context.auth.token.email || '';

  // Validate required fields
  if (!amount || !plan_id) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      'Missing required fields: amount, plan_id'
    );
  }

  try {
    // Create PaymentIntent
    const paymentIntent = await stripe.paymentIntents.create({
      amount: amount,
      currency: 'usd',
      automatic_payment_methods: {
        enabled: true,
      },
      metadata: {
        app: 'tinseltown_iq',
        plan_id: plan_id,
        user_id: user_id,
        user_email: user_email,
      },
      receipt_email: user_email,
      description: `Tinseltown IQ - ${plan_id} Plan Subscription`,
    });

    console.log(`PaymentIntent created: ${paymentIntent.id} for user ${user_id}`);

    return {
      clientSecret: paymentIntent.client_secret,
      paymentIntentId: paymentIntent.id,
    };

  } catch (error) {
    console.error('Error creating PaymentIntent:', error);
    throw new functions.https.HttpsError('internal', error.message);
  }
});

// ═══════════════════════════════════════════════════════════════
// STRIPE WEBHOOK - Handle payment events
// ═══════════════════════════════════════════════════════════════

/**
 * Webhook endpoint for Stripe events
 * Configure in Stripe Dashboard: Dashboard > Webhooks > Add endpoint
 * URL: https://us-central1-YOUR_PROJECT.cloudfunctions.net/stripeWebhook
 * Events to listen for:
 *   - payment_intent.succeeded
 *   - payment_intent.payment_failed
 *   - customer.subscription.created
 *   - customer.subscription.updated
 *   - customer.subscription.deleted
 */
exports.stripeWebhook = functions.https.onRequest(async (req, res) => {
  const sig = req.headers['stripe-signature'];
  const webhookSecret = functions.config().stripe.webhook_secret;

  let event;

  try {
    // Verify webhook signature
    event = stripe.webhooks.constructEvent(req.rawBody, sig, webhookSecret);
  } catch (err) {
    console.error('Webhook signature verification failed:', err.message);
    res.status(400).send(`Webhook Error: ${err.message}`);
    return;
  }

  // Handle the event
  switch (event.type) {
    case 'payment_intent.succeeded':
      await handlePaymentSuccess(event.data.object);
      break;

    case 'payment_intent.payment_failed':
      await handlePaymentFailure(event.data.object);
      break;

    case 'customer.subscription.created':
    case 'customer.subscription.updated':
      await handleSubscriptionUpdate(event.data.object);
      break;

    case 'customer.subscription.deleted':
      await handleSubscriptionCanceled(event.data.object);
      break;

    default:
      console.log(`Unhandled event type: ${event.type}`);
  }

  res.json({ received: true });
});

// ═══════════════════════════════════════════════════════════════
// WEBHOOK HANDLERS
// ═══════════════════════════════════════════════════════════════

/**
 * Handle successful payment
 */
async function handlePaymentSuccess(paymentIntent) {
  const { user_id, plan_id, user_email } = paymentIntent.metadata;

  if (!user_id || !plan_id) {
    console.error('Missing metadata in PaymentIntent');
    return;
  }

  console.log(`Payment succeeded for user ${user_id}, plan ${plan_id}`);

  try {
    // Update user's subscription in Firestore
    const userRef = db.collection('users').doc(user_id);
    
    await userRef.set({
      subscription: {
        plan: plan_id,
        status: 'active',
        updated_at: admin.firestore.FieldValue.serverTimestamp(),
        payment_intent_id: paymentIntent.id,
        amount_paid: paymentIntent.amount,
        currency: paymentIntent.currency,
      },
      // Reset scan count for new subscription period
      scans_used: 0,
      scans_reset_at: admin.firestore.FieldValue.serverTimestamp(),
    }, { merge: true });

    // Log transaction
    await db.collection('transactions').add({
      user_id: user_id,
      user_email: user_email,
      plan_id: plan_id,
      payment_intent_id: paymentIntent.id,
      amount: paymentIntent.amount,
      currency: paymentIntent.currency,
      status: 'succeeded',
      created_at: admin.firestore.FieldValue.serverTimestamp(),
    });

    console.log(`User ${user_id} subscription updated to ${plan_id}`);

  } catch (error) {
    console.error('Error updating user subscription:', error);
  }
}

/**
 * Handle failed payment
 */
async function handlePaymentFailure(paymentIntent) {
  const { user_id, plan_id, user_email } = paymentIntent.metadata;

  console.log(`Payment failed for user ${user_id}, plan ${plan_id}`);

  try {
    // Log failed transaction
    await db.collection('transactions').add({
      user_id: user_id || 'unknown',
      user_email: user_email || '',
      plan_id: plan_id || 'unknown',
      payment_intent_id: paymentIntent.id,
      amount: paymentIntent.amount,
      currency: paymentIntent.currency,
      status: 'failed',
      failure_message: paymentIntent.last_payment_error?.message || 'Unknown error',
      created_at: admin.firestore.FieldValue.serverTimestamp(),
    });

  } catch (error) {
    console.error('Error logging failed payment:', error);
  }
}

/**
 * Handle subscription update
 */
async function handleSubscriptionUpdate(subscription) {
  const customerId = subscription.customer;
  
  // In a real app, you'd look up the user by Stripe customer ID
  console.log(`Subscription updated for customer ${customerId}:`, subscription.status);
}

/**
 * Handle subscription cancellation
 */
async function handleSubscriptionCanceled(subscription) {
  const customerId = subscription.customer;
  
  console.log(`Subscription canceled for customer ${customerId}`);
  
  // In a real app, you'd downgrade the user to free plan
}

// ═══════════════════════════════════════════════════════════════
// UTILITY FUNCTIONS
// ═══════════════════════════════════════════════════════════════

/**
 * Get user's current subscription status
 */
exports.getSubscriptionStatus = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be logged in');
  }

  const user_id = context.auth.uid;

  try {
    const userDoc = await db.collection('users').doc(user_id).get();
    
    if (!userDoc.exists) {
      return {
        plan: 'free',
        status: 'active',
        scans_used: 0,
        scans_remaining: 3,
      };
    }

    const userData = userDoc.data();
    const subscription = userData.subscription || { plan: 'free', status: 'active' };
    const scansUsed = userData.scans_used || 0;

    // Calculate scans remaining based on plan
    let scansRemaining;
    switch (subscription.plan) {
      case 'professional':
        scansRemaining = 25 - scansUsed;
        break;
      case 'studio':
        scansRemaining = 999; // Unlimited
        break;
      default:
        scansRemaining = 3 - scansUsed;
    }

    return {
      plan: subscription.plan,
      status: subscription.status,
      scans_used: scansUsed,
      scans_remaining: Math.max(0, scansRemaining),
      updated_at: subscription.updated_at,
    };

  } catch (error) {
    console.error('Error getting subscription status:', error);
    throw new functions.https.HttpsError('internal', error.message);
  }
});

/**
 * Cancel subscription
 */
exports.cancelSubscription = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be logged in');
  }

  const user_id = context.auth.uid;

  try {
    // Update user to free plan
    await db.collection('users').doc(user_id).set({
      subscription: {
        plan: 'free',
        status: 'active',
        updated_at: admin.firestore.FieldValue.serverTimestamp(),
        canceled_at: admin.firestore.FieldValue.serverTimestamp(),
      },
    }, { merge: true });

    console.log(`Subscription canceled for user ${user_id}`);

    return { success: true, message: 'Subscription canceled' };

  } catch (error) {
    console.error('Error canceling subscription:', error);
    throw new functions.https.HttpsError('internal', error.message);
  }
});
