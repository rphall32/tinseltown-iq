import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Application Localizations
/// 
/// Provides localized strings and locale-aware formatting for the app.
/// Supports English (en) and Spanish (es) with fallback to English.
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  /// Helper method to get the current localizations from context
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(const Locale('en'));
  }

  /// LocalizationsDelegate for use with MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// Supported locales
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('de'),
    Locale('ja'),
    Locale('zh'),
  ];

  /// Check if a locale is supported
  static bool isSupported(Locale locale) {
    return supportedLocales.any((l) => l.languageCode == locale.languageCode);
  }

  // ═══════════════════════════════════════════════════════════════
  // Localized Strings Storage
  // ═══════════════════════════════════════════════════════════════
  
  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'Tinseltown IQ',
      'welcome': 'Welcome',
      'welcomeBack': 'Welcome back',
      'signIn': 'Sign In',
      'signUp': 'Sign Up',
      'signOut': 'Sign Out',
      'email': 'Email',
      'password': 'Password',
      'forgotPassword': 'Forgot Password?',
      'home': 'Home',
      'projects': 'Projects',
      'newScan': 'New Scan',
      'profile': 'Profile',
      'settings': 'Settings',
      'darkMode': 'Dark Mode',
      'lightMode': 'Light Mode',
      'systemDefault': 'System Default',
      'language': 'Language',
      'notifications': 'Notifications',
      'greenlightScore': 'GreenlightIQ Score',
      'analyzing': 'Analyzing...',
      'analysisComplete': 'Analysis Complete',
      'projectTitle': 'Project Title',
      'logline': 'Logline',
      'synopsis': 'Synopsis',
      'genre': 'Genre',
      'format': 'Format',
      'analyze': 'Analyze',
      'reAnalyze': 'Re-Analyze',
      'save': 'Save',
      'cancel': 'Cancel',
      'delete': 'Delete',
      'confirm': 'Confirm',
      'retry': 'Retry',
      'loading': 'Loading...',
      'error': 'Error',
      'success': 'Success',
      'somethingWentWrong': 'Something went wrong',
      'tryAgain': 'Try Again',
      'noProjectsYet': 'No projects yet',
      'createFirstProject': 'Create your first project to get started',
      'searchProjects': 'Search projects...',
      'subscription': 'Subscription',
      'freePlan': 'Free Plan',
      'proPlan': 'Pro Plan',
      'studioPlan': 'Studio Plan',
      'upgrade': 'Upgrade',
      'compareProjects': 'Compare Projects',
      'selectProjectsToCompare': 'Select up to 3 projects to compare',
      'marketInsights': 'Market Insights',
      'creativeFeedback': 'Creative Feedback',
      'topBuyers': 'Top Buyers',
      'similarTitles': 'Similar Titles',
      'exportPdf': 'Export PDF',
      'share': 'Share',
      'addToFavorites': 'Add to Favorites',
      'removeFromFavorites': 'Remove from Favorites',
      'favorites': 'Favorites',
      'all': 'All',
      'recent': 'Recent',
      'highScore': 'High Score',
      'offline': 'Offline',
      'online': 'Online',
      'noInternetConnection': 'No internet connection',
      'checkConnectionAndTryAgain': 'Please check your connection and try again',
    },
    'es': {
      'appTitle': 'Tinseltown IQ',
      'welcome': 'Bienvenido',
      'welcomeBack': 'Bienvenido de nuevo',
      'signIn': 'Iniciar Sesion',
      'signUp': 'Registrarse',
      'signOut': 'Cerrar Sesion',
      'email': 'Correo electronico',
      'password': 'Contrasena',
      'forgotPassword': 'Olvidaste tu contrasena?',
      'home': 'Inicio',
      'projects': 'Proyectos',
      'newScan': 'Nuevo Escaneo',
      'profile': 'Perfil',
      'settings': 'Configuracion',
      'darkMode': 'Modo Oscuro',
      'lightMode': 'Modo Claro',
      'systemDefault': 'Predeterminado del Sistema',
      'language': 'Idioma',
      'notifications': 'Notificaciones',
      'greenlightScore': 'Puntuacion GreenlightIQ',
      'analyzing': 'Analizando...',
      'analysisComplete': 'Analisis Completo',
      'projectTitle': 'Titulo del Proyecto',
      'logline': 'Logline',
      'synopsis': 'Sinopsis',
      'genre': 'Genero',
      'format': 'Formato',
      'analyze': 'Analizar',
      'reAnalyze': 'Re-Analizar',
      'save': 'Guardar',
      'cancel': 'Cancelar',
      'delete': 'Eliminar',
      'confirm': 'Confirmar',
      'retry': 'Reintentar',
      'loading': 'Cargando...',
      'error': 'Error',
      'success': 'Exito',
      'somethingWentWrong': 'Algo salio mal',
      'tryAgain': 'Intentar de Nuevo',
      'noProjectsYet': 'Aun no hay proyectos',
      'createFirstProject': 'Crea tu primer proyecto para comenzar',
      'searchProjects': 'Buscar proyectos...',
      'subscription': 'Suscripcion',
      'freePlan': 'Plan Gratuito',
      'proPlan': 'Plan Pro',
      'studioPlan': 'Plan Estudio',
      'upgrade': 'Mejorar',
      'compareProjects': 'Comparar Proyectos',
      'selectProjectsToCompare': 'Selecciona hasta 3 proyectos para comparar',
      'marketInsights': 'Perspectivas de Mercado',
      'creativeFeedback': 'Retroalimentacion Creativa',
      'topBuyers': 'Principales Compradores',
      'similarTitles': 'Titulos Similares',
      'exportPdf': 'Exportar PDF',
      'share': 'Compartir',
      'addToFavorites': 'Agregar a Favoritos',
      'removeFromFavorites': 'Quitar de Favoritos',
      'favorites': 'Favoritos',
      'all': 'Todos',
      'recent': 'Reciente',
      'highScore': 'Puntuacion Alta',
      'offline': 'Sin conexion',
      'online': 'En linea',
      'noInternetConnection': 'Sin conexion a internet',
      'checkConnectionAndTryAgain': 'Por favor verifica tu conexion e intenta de nuevo',
    },
  };

  String _translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ??
           _localizedValues['en']?[key] ??
           key;
  }

  // ═══════════════════════════════════════════════════════════════
  // Localized String Getters
  // ═══════════════════════════════════════════════════════════════

  String get appTitle => _translate('appTitle');
  String get welcome => _translate('welcome');
  String get welcomeBack => _translate('welcomeBack');
  String get signIn => _translate('signIn');
  String get signUp => _translate('signUp');
  String get signOut => _translate('signOut');
  String get email => _translate('email');
  String get password => _translate('password');
  String get forgotPassword => _translate('forgotPassword');
  String get home => _translate('home');
  String get projects => _translate('projects');
  String get newScan => _translate('newScan');
  String get profile => _translate('profile');
  String get settings => _translate('settings');
  String get darkMode => _translate('darkMode');
  String get lightMode => _translate('lightMode');
  String get systemDefault => _translate('systemDefault');
  String get language => _translate('language');
  String get notifications => _translate('notifications');
  String get greenlightScore => _translate('greenlightScore');
  String get analyzing => _translate('analyzing');
  String get analysisComplete => _translate('analysisComplete');
  String get projectTitle => _translate('projectTitle');
  String get logline => _translate('logline');
  String get synopsis => _translate('synopsis');
  String get genre => _translate('genre');
  String get format => _translate('format');
  String get analyze => _translate('analyze');
  String get reAnalyze => _translate('reAnalyze');
  String get save => _translate('save');
  String get cancel => _translate('cancel');
  String get delete => _translate('delete');
  String get confirm => _translate('confirm');
  String get retry => _translate('retry');
  String get loading => _translate('loading');
  String get error => _translate('error');
  String get success => _translate('success');
  String get somethingWentWrong => _translate('somethingWentWrong');
  String get tryAgain => _translate('tryAgain');
  String get noProjectsYet => _translate('noProjectsYet');
  String get createFirstProject => _translate('createFirstProject');
  String get searchProjects => _translate('searchProjects');
  String get subscription => _translate('subscription');
  String get freePlan => _translate('freePlan');
  String get proPlan => _translate('proPlan');
  String get studioPlan => _translate('studioPlan');
  String get upgrade => _translate('upgrade');
  String get compareProjects => _translate('compareProjects');
  String get selectProjectsToCompare => _translate('selectProjectsToCompare');
  String get marketInsights => _translate('marketInsights');
  String get creativeFeedback => _translate('creativeFeedback');
  String get topBuyers => _translate('topBuyers');
  String get similarTitles => _translate('similarTitles');
  String get exportPdf => _translate('exportPdf');
  String get share => _translate('share');
  String get addToFavorites => _translate('addToFavorites');
  String get removeFromFavorites => _translate('removeFromFavorites');
  String get favorites => _translate('favorites');
  String get all => _translate('all');
  String get recent => _translate('recent');
  String get highScore => _translate('highScore');
  String get offline => _translate('offline');
  String get online => _translate('online');
  String get noInternetConnection => _translate('noInternetConnection');
  String get checkConnectionAndTryAgain => _translate('checkConnectionAndTryAgain');

  // ═══════════════════════════════════════════════════════════════
  // Parameterized Strings
  // ═══════════════════════════════════════════════════════════════

  String scoreOutOf100(int score) {
    return locale.languageCode == 'es' 
        ? 'Puntuacion: $score/100'
        : 'Score: $score/100';
  }

  String scansRemaining(int count) {
    if (locale.languageCode == 'es') {
      if (count == 0) return 'No quedan escaneos';
      if (count == 1) return '1 escaneo restante';
      return '$count escaneos restantes';
    }
    if (count == 0) return 'No scans remaining';
    if (count == 1) return '1 scan remaining';
    return '$count scans remaining';
  }

  String lastUpdated(String date) {
    return locale.languageCode == 'es'
        ? 'Ultima actualizacion $date'
        : 'Last updated $date';
  }

  String createdOn(String date) {
    return locale.languageCode == 'es'
        ? 'Creado el $date'
        : 'Created on $date';
  }
}

/// LocalizationsDelegate implementation
class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => AppLocalizations.isSupported(locale);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return Future.value(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

/// Locale-aware date formatting utilities
class LocaleAwareDateFormatter {
  final Locale locale;
  
  LocaleAwareDateFormatter(this.locale);
  
  /// Format a date for display (e.g., "January 15, 2024" or "15 de enero de 2024")
  String formatDate(DateTime date) {
    return DateFormat.yMMMMd(locale.languageCode).format(date);
  }
  
  /// Format a short date (e.g., "Jan 15" or "15 ene")
  String formatShortDate(DateTime date) {
    return DateFormat.MMMd(locale.languageCode).format(date);
  }
  
  /// Format time (e.g., "3:30 PM" or "15:30")
  String formatTime(DateTime time) {
    return DateFormat.jm(locale.languageCode).format(time);
  }
  
  /// Format date and time together
  String formatDateTime(DateTime dateTime) {
    return '${formatDate(dateTime)} ${formatTime(dateTime)}';
  }
  
  /// Format relative time (e.g., "2 hours ago", "yesterday")
  String formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inMinutes < 1) {
      return locale.languageCode == 'es' ? 'Justo ahora' : 'Just now';
    }
    
    if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      if (locale.languageCode == 'es') {
        return minutes == 1 ? 'Hace 1 minuto' : 'Hace $minutes minutos';
      }
      return minutes == 1 ? '1 minute ago' : '$minutes minutes ago';
    }
    
    if (difference.inHours < 24) {
      final hours = difference.inHours;
      if (locale.languageCode == 'es') {
        return hours == 1 ? 'Hace 1 hora' : 'Hace $hours horas';
      }
      return hours == 1 ? '1 hour ago' : '$hours hours ago';
    }
    
    if (difference.inDays < 7) {
      final days = difference.inDays;
      if (locale.languageCode == 'es') {
        if (days == 1) return 'Ayer';
        return 'Hace $days dias';
      }
      if (days == 1) return 'Yesterday';
      return '$days days ago';
    }
    
    if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      if (locale.languageCode == 'es') {
        return weeks == 1 ? 'Hace 1 semana' : 'Hace $weeks semanas';
      }
      return weeks == 1 ? '1 week ago' : '$weeks weeks ago';
    }
    
    // For older dates, show the actual date
    return formatShortDate(dateTime);
  }
}

/// Locale-aware number formatting utilities
class LocaleAwareNumberFormatter {
  final Locale locale;
  
  LocaleAwareNumberFormatter(this.locale);
  
  /// Format a number with locale-specific thousands separator
  String formatNumber(num number) {
    return NumberFormat.decimalPattern(locale.languageCode).format(number);
  }
  
  /// Format currency
  String formatCurrency(double amount, {String symbol = '\$'}) {
    return NumberFormat.currency(
      locale: locale.languageCode,
      symbol: symbol,
      decimalDigits: 2,
    ).format(amount);
  }
  
  /// Format percentage
  String formatPercent(double value) {
    return NumberFormat.percentPattern(locale.languageCode).format(value);
  }
  
  /// Format compact number (e.g., 1.2K, 3.4M)
  String formatCompact(num number) {
    return NumberFormat.compact(locale: locale.languageCode).format(number);
  }
}

/// Extension for easy access to localizations
extension LocalizationsExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
  
  LocaleAwareDateFormatter get dateFormatter => 
      LocaleAwareDateFormatter(Localizations.localeOf(this));
  
  LocaleAwareNumberFormatter get numberFormatter => 
      LocaleAwareNumberFormatter(Localizations.localeOf(this));
}
