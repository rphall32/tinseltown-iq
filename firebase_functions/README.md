# Tinseltown IQ - Firebase Cloud Functions for Stripe Payments

## Overview

This directory contains Firebase Cloud Functions that handle Stripe payment processing for the Tinseltown IQ app.

## Functions

| Function | Type | Description |
|----------|------|-------------|
| `createPaymentIntent` | HTTP POST | Creates a Stripe PaymentIntent (public endpoint) |
| `createPaymentIntentAuth` | Callable | Creates a PaymentIntent (requires Firebase Auth) |
| `stripeWebhook` | HTTP POST | Handles Stripe webhook events |
| `getSubscriptionStatus` | Callable | Gets user's current subscription |
| `cancelSubscription` | Callable | Cancels user's subscription |

## Setup Instructions

### 1. Prerequisites

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login to Firebase
firebase login

# Select your project
firebase use YOUR_PROJECT_ID
```

### 2. Initialize Functions

```bash
# Navigate to your Firebase project root
cd your-firebase-project

# Initialize functions (if not already done)
firebase init functions

# Select JavaScript, ESLint, and install dependencies
```

### 3. Copy Function Files

```bash
# Copy index.js to functions directory
cp firebase_functions/index.js functions/index.js

# Copy package.json dependencies
# Then run: cd functions && npm install
```

### 4. Configure Stripe Keys

```bash
# Set your Stripe secret key (from Stripe Dashboard)
firebase functions:config:set stripe.secret="sk_test_YOUR_SECRET_KEY"

# Set webhook secret (after creating webhook in Stripe Dashboard)
firebase functions:config:set stripe.webhook_secret="whsec_YOUR_WEBHOOK_SECRET"

# Verify configuration
firebase functions:config:get
```

### 5. Deploy Functions

```bash
firebase deploy --only functions
```

### 6. Configure Stripe Webhook

1. Go to [Stripe Dashboard → Webhooks](https://dashboard.stripe.com/webhooks)
2. Click "Add endpoint"
3. Enter URL: `https://us-central1-YOUR_PROJECT.cloudfunctions.net/stripeWebhook`
4. Select events:
   - `payment_intent.succeeded`
   - `payment_intent.payment_failed`
   - `customer.subscription.created`
   - `customer.subscription.updated`
   - `customer.subscription.deleted`
5. Copy the webhook signing secret
6. Update Firebase config: `firebase functions:config:set stripe.webhook_secret="whsec_..."`

## Flutter App Configuration

Update `PaymentService` in your Flutter app with:

```dart
// In lib/main.dart - PaymentService class
static const String stripePublishableKey = 'pk_test_YOUR_KEY';
static const String backendUrl = 'https://us-central1-YOUR_PROJECT.cloudfunctions.net';
static bool mockMode = false; // Set to false for real payments
```

## Testing

### Test Cards

| Card Number | Scenario |
|-------------|----------|
| `4242 4242 4242 4242` | Successful payment |
| `4000 0000 0000 0002` | Card declined |
| `4000 0025 0000 3155` | 3D Secure required |
| `4000 0000 0000 9995` | Insufficient funds |

Use any future expiry date and any 3-digit CVC.

### Test Webhook Locally

```bash
# Install Stripe CLI
brew install stripe/stripe-cli/stripe

# Login to Stripe
stripe login

# Forward webhooks to local emulator
stripe listen --forward-to localhost:5001/YOUR_PROJECT/us-central1/stripeWebhook

# Use the webhook secret displayed
```

## Security Notes

1. **Never expose `sk_secret_` keys** in client code
2. **Validate webhook signatures** to prevent fake events
3. **Use Firebase Auth** for callable functions when possible
4. **Enable Firestore security rules** to protect user data

## Firestore Security Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can only read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Transactions are read-only for users
    match /transactions/{transactionId} {
      allow read: if request.auth != null && 
                   resource.data.user_id == request.auth.uid;
      allow write: if false; // Only Cloud Functions can write
    }
  }
}
```

## Troubleshooting

### "CORS error" when calling createPaymentIntent
- Ensure CORS headers are set in the function
- Check if the function URL is correct

### "Webhook signature verification failed"
- Verify webhook secret is set correctly
- Check if using test vs live webhook secret

### "User subscription not updating"
- Check Firestore permissions
- Verify user_id is in PaymentIntent metadata
- Check Cloud Functions logs: `firebase functions:log`

## Cost Considerations

- Firebase Functions: First 2M invocations/month free
- Stripe: 2.9% + 30¢ per successful card charge
- Firestore: First 50K reads/day free, 20K writes/day free
