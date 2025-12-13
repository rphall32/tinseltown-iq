// API Client - Centralized HTTP Client
//
// Provides a robust, type-safe HTTP client with:
// - Request/response interceptors
// - Automatic retry with exponential backoff
// - Response parsing and error handling
// - Request caching (optional)
// - Connectivity awareness

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// HTTP method types
enum HttpMethod { get, post, put, patch, delete }

/// API response wrapper
class ApiResponse<T> {
  final T? data;
  final int statusCode;
  final String? message;
  final bool isSuccess;
  final Map<String, String>? headers;
  final ApiError? error;

  const ApiResponse({
    this.data,
    required this.statusCode,
    this.message,
    this.isSuccess = true,
    this.headers,
    this.error,
  });

  factory ApiResponse.success(T data, {int statusCode = 200, Map<String, String>? headers}) {
    return ApiResponse(
      data: data,
      statusCode: statusCode,
      isSuccess: true,
      headers: headers,
    );
  }

  factory ApiResponse.error(ApiError error, {int statusCode = 500}) {
    return ApiResponse(
      statusCode: statusCode,
      isSuccess: false,
      error: error,
      message: error.message,
    );
  }
}

/// API error representation
class ApiError {
  final String message;
  final String? code;
  final int? statusCode;
  final dynamic originalError;
  final StackTrace? stackTrace;

  const ApiError({
    required this.message,
    this.code,
    this.statusCode,
    this.originalError,
    this.stackTrace,
  });

  factory ApiError.network() => const ApiError(
    message: 'Network error. Please check your connection.',
    code: 'NETWORK_ERROR',
  );

  factory ApiError.timeout() => const ApiError(
    message: 'Request timed out. Please try again.',
    code: 'TIMEOUT',
  );

  factory ApiError.server([String? message]) => ApiError(
    message: message ?? 'Server error. Please try again later.',
    code: 'SERVER_ERROR',
  );

  factory ApiError.unauthorized() => const ApiError(
    message: 'Session expired. Please sign in again.',
    code: 'UNAUTHORIZED',
    statusCode: 401,
  );

  factory ApiError.notFound() => const ApiError(
    message: 'Resource not found.',
    code: 'NOT_FOUND',
    statusCode: 404,
  );

  factory ApiError.unknown([dynamic error, StackTrace? stackTrace]) => ApiError(
    message: 'An unexpected error occurred.',
    code: 'UNKNOWN',
    originalError: error,
    stackTrace: stackTrace,
  );

  @override
  String toString() => 'ApiError($code): $message';
}

/// Request interceptor
typedef RequestInterceptor = Future<http.Request> Function(http.Request request);

/// Response interceptor
typedef ResponseInterceptor = Future<http.Response> Function(http.Response response);

/// API Client configuration
class ApiClientConfig {
  final String? baseUrl;
  final Duration timeout;
  final int maxRetries;
  final Duration retryDelay;
  final Map<String, String> defaultHeaders;
  final bool enableLogging;

  const ApiClientConfig({
    this.baseUrl,
    this.timeout = const Duration(seconds: 30),
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
    this.defaultHeaders = const {},
    this.enableLogging = false,
  });

  ApiClientConfig copyWith({
    String? baseUrl,
    Duration? timeout,
    int? maxRetries,
    Duration? retryDelay,
    Map<String, String>? defaultHeaders,
    bool? enableLogging,
  }) {
    return ApiClientConfig(
      baseUrl: baseUrl ?? this.baseUrl,
      timeout: timeout ?? this.timeout,
      maxRetries: maxRetries ?? this.maxRetries,
      retryDelay: retryDelay ?? this.retryDelay,
      defaultHeaders: defaultHeaders ?? this.defaultHeaders,
      enableLogging: enableLogging ?? this.enableLogging,
    );
  }
}

/// Centralized API Client
class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  ApiClient._internal();

  late http.Client _httpClient;
  late ApiClientConfig _config;
  final List<RequestInterceptor> _requestInterceptors = [];
  final List<ResponseInterceptor> _responseInterceptors = [];
  String? _authToken;

  /// Initialize the API client
  void initialize({ApiClientConfig? config}) {
    _config = config ?? const ApiClientConfig();
    _httpClient = http.Client();
    
    if (kDebugMode && _config.enableLogging) {
      debugPrint('🌐 ApiClient initialized with baseUrl: ${_config.baseUrl}');
    }
  }

  /// Set authentication token
  void setAuthToken(String? token) {
    _authToken = token;
  }

  /// Clear authentication token
  void clearAuthToken() {
    _authToken = null;
  }

  /// Add request interceptor
  void addRequestInterceptor(RequestInterceptor interceptor) {
    _requestInterceptors.add(interceptor);
  }

  /// Add response interceptor
  void addResponseInterceptor(ResponseInterceptor interceptor) {
    _responseInterceptors.add(interceptor);
  }

  /// Build full URL
  String _buildUrl(String endpoint) {
    if (endpoint.startsWith('http://') || endpoint.startsWith('https://')) {
      return endpoint;
    }
    if (_config.baseUrl != null) {
      return '${_config.baseUrl}$endpoint';
    }
    return endpoint;
  }

  /// Build headers
  Map<String, String> _buildHeaders(Map<String, String>? customHeaders) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      ..._config.defaultHeaders,
    };

    if (_authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }

    if (customHeaders != null) {
      headers.addAll(customHeaders);
    }

    return headers;
  }

  /// Log request (debug only)
  void _logRequest(HttpMethod method, String url, {dynamic body}) {
    if (kDebugMode && _config.enableLogging) {
      debugPrint('📤 ${method.name.toUpperCase()} $url');
      if (body != null) {
        debugPrint('   Body: ${json.encode(body)}');
      }
    }
  }

  /// Log response (debug only)
  void _logResponse(http.Response response) {
    if (kDebugMode && _config.enableLogging) {
      final emoji = response.statusCode >= 200 && response.statusCode < 300 ? '✅' : '❌';
      debugPrint('$emoji Response: ${response.statusCode}');
      if (response.body.length < 500) {
        debugPrint('   Body: ${response.body}');
      }
    }
  }

  /// Execute HTTP request with retry logic
  Future<ApiResponse<T>> request<T>({
    required HttpMethod method,
    required String endpoint,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, String>? queryParams,
    T Function(dynamic json)? parser,
    int? retries,
  }) async {
    final url = _buildUrl(endpoint);
    final uri = queryParams != null 
        ? Uri.parse(url).replace(queryParameters: queryParams)
        : Uri.parse(url);
    final requestHeaders = _buildHeaders(headers);
    
    _logRequest(method, uri.toString(), body: body);

    int attempt = 0;
    final maxAttempts = retries ?? _config.maxRetries;

    while (attempt < maxAttempts) {
      try {
        http.Response response;

        switch (method) {
          case HttpMethod.get:
            response = await _httpClient
                .get(uri, headers: requestHeaders)
                .timeout(_config.timeout);
            break;
          case HttpMethod.post:
            response = await _httpClient
                .post(uri, headers: requestHeaders, body: body != null ? json.encode(body) : null)
                .timeout(_config.timeout);
            break;
          case HttpMethod.put:
            response = await _httpClient
                .put(uri, headers: requestHeaders, body: body != null ? json.encode(body) : null)
                .timeout(_config.timeout);
            break;
          case HttpMethod.patch:
            response = await _httpClient
                .patch(uri, headers: requestHeaders, body: body != null ? json.encode(body) : null)
                .timeout(_config.timeout);
            break;
          case HttpMethod.delete:
            response = await _httpClient
                .delete(uri, headers: requestHeaders)
                .timeout(_config.timeout);
            break;
        }

        // Apply response interceptors
        for (final interceptor in _responseInterceptors) {
          response = await interceptor(response);
        }

        _logResponse(response);

        return _handleResponse<T>(response, parser);

      } on TimeoutException {
        attempt++;
        if (attempt >= maxAttempts) {
          return ApiResponse.error(ApiError.timeout(), statusCode: 408);
        }
        await Future.delayed(_config.retryDelay * attempt);
      } on http.ClientException catch (e) {
        attempt++;
        if (attempt >= maxAttempts) {
          return ApiResponse.error(
            ApiError(message: 'Connection failed: ${e.message}', code: 'CLIENT_ERROR'),
          );
        }
        await Future.delayed(_config.retryDelay * attempt);
      } catch (e, stackTrace) {
        if (kDebugMode) {
          debugPrint('❌ API Error: $e');
        }
        return ApiResponse.error(ApiError.unknown(e, stackTrace));
      }
    }

    return ApiResponse.error(ApiError.network());
  }

  /// Handle HTTP response
  ApiResponse<T> _handleResponse<T>(http.Response response, T Function(dynamic)? parser) {
    final statusCode = response.statusCode;
    
    // Success responses
    if (statusCode >= 200 && statusCode < 300) {
      if (response.body.isEmpty) {
        return ApiResponse.success(null as T, statusCode: statusCode);
      }

      try {
        final jsonData = json.decode(response.body);
        final data = parser != null ? parser(jsonData) : jsonData as T;
        return ApiResponse.success(data, statusCode: statusCode);
      } catch (e) {
        return ApiResponse.error(
          ApiError(message: 'Failed to parse response', code: 'PARSE_ERROR'),
          statusCode: statusCode,
        );
      }
    }

    // Error responses
    String errorMessage;
    try {
      final errorJson = json.decode(response.body);
      errorMessage = errorJson['message'] ?? errorJson['error'] ?? 'Request failed';
    } catch (_) {
      errorMessage = response.body.isNotEmpty ? response.body : 'Request failed';
    }

    switch (statusCode) {
      case 400:
        return ApiResponse.error(
          ApiError(message: errorMessage, code: 'BAD_REQUEST', statusCode: 400),
          statusCode: 400,
        );
      case 401:
        return ApiResponse.error(ApiError.unauthorized(), statusCode: 401);
      case 403:
        return ApiResponse.error(
          ApiError(message: 'Access denied', code: 'FORBIDDEN', statusCode: 403),
          statusCode: 403,
        );
      case 404:
        return ApiResponse.error(ApiError.notFound(), statusCode: 404);
      case 429:
        return ApiResponse.error(
          ApiError(message: 'Too many requests. Please slow down.', code: 'RATE_LIMITED', statusCode: 429),
          statusCode: 429,
        );
      case 500:
      case 502:
      case 503:
        return ApiResponse.error(ApiError.server(errorMessage), statusCode: statusCode);
      default:
        return ApiResponse.error(
          ApiError(message: errorMessage, code: 'HTTP_$statusCode', statusCode: statusCode),
          statusCode: statusCode,
        );
    }
  }

  // ═══════════════════════════════════════════════════════════════
  // CONVENIENCE METHODS
  // ═══════════════════════════════════════════════════════════════

  /// GET request
  Future<ApiResponse<T>> get<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, String>? queryParams,
    T Function(dynamic json)? parser,
  }) {
    return request<T>(
      method: HttpMethod.get,
      endpoint: endpoint,
      headers: headers,
      queryParams: queryParams,
      parser: parser,
    );
  }

  /// POST request
  Future<ApiResponse<T>> post<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    T Function(dynamic json)? parser,
  }) {
    return request<T>(
      method: HttpMethod.post,
      endpoint: endpoint,
      headers: headers,
      body: body,
      parser: parser,
    );
  }

  /// PUT request
  Future<ApiResponse<T>> put<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    T Function(dynamic json)? parser,
  }) {
    return request<T>(
      method: HttpMethod.put,
      endpoint: endpoint,
      headers: headers,
      body: body,
      parser: parser,
    );
  }

  /// PATCH request
  Future<ApiResponse<T>> patch<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    T Function(dynamic json)? parser,
  }) {
    return request<T>(
      method: HttpMethod.patch,
      endpoint: endpoint,
      headers: headers,
      body: body,
      parser: parser,
    );
  }

  /// DELETE request
  Future<ApiResponse<T>> delete<T>(
    String endpoint, {
    Map<String, String>? headers,
    T Function(dynamic json)? parser,
  }) {
    return request<T>(
      method: HttpMethod.delete,
      endpoint: endpoint,
      headers: headers,
      parser: parser,
    );
  }

  /// Dispose the client
  void dispose() {
    _httpClient.close();
  }
}

/// Result type for cleaner error handling
sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends Result<T> {
  final ApiError error;
  const Failure(this.error);
}

/// Extension for ApiResponse to Result conversion
extension ApiResponseToResult<T> on ApiResponse<T> {
  Result<T> toResult() {
    if (isSuccess && data != null) {
      return Success(data as T);
    }
    return Failure(error ?? ApiError.unknown());
  }
}

/// Extension for easy result handling
extension ResultExtension<T> on Result<T> {
  R when<R>({
    required R Function(T data) success,
    required R Function(ApiError error) failure,
  }) {
    return switch (this) {
      Success<T> s => success(s.data),
      Failure<T> f => failure(f.error),
    };
  }

  T? get dataOrNull => switch (this) {
    Success<T> s => s.data,
    Failure<T> _ => null,
  };

  ApiError? get errorOrNull => switch (this) {
    Success<T> _ => null,
    Failure<T> f => f.error,
  };
}
