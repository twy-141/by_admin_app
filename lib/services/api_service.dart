// lib/services/api_service.dart
import 'package:dio/dio.dart';
import 'package:by_admin_app/services/storage_service.dart';

// 统一响应模型 - 根据你的实际结构调整
class ApiResponse<T> {
  final int code;
  final String msg;
  final T? data;

  ApiResponse({
    required this.code,
    required this.msg,
    this.data,
  });

  bool get success => code == 200;

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return ApiResponse<T>(
      code: json['code'] ?? 0,
      msg: json['msg'] ?? '',
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }
}

// 自定义异常
class ApiException implements Exception {
  final String message;
  final int? code;

  ApiException(this.message, {this.code});

  @override
  String toString() => 'ApiException: $message${code != null ? ' (code: $code)' : ''}';
}

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  
  late final Dio _dio;

  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://qmdzapi.qunmeng.club/',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: _onRequest,
      onResponse: _onResponse,
      onError: _onError,
    ));
  }

  Future<void> _onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await StorageService.getString('token');
    if (token != null) {
      options.headers['token'] = token;
    }
    handler.next(options);
  }

  Future<void> _onResponse(Response response, ResponseInterceptorHandler handler) async {
    handler.next(response);
  }

  Future<void> _onError(DioException e, ErrorInterceptorHandler handler) async {
    if (e.response?.statusCode == 401) {
      await StorageService.remove('token');
      // 这里可以添加跳转到登录页的逻辑
    }
    handler.next(e);
  }

  // 类型安全的 GET 请求
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
      
      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // 类型安全的 POST 请求
  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
      
      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // 统一处理响应
  ApiResponse<T> _handleResponse<T>(Response response, T Function(dynamic)? fromJson) {
    if (response.data is! Map<String, dynamic>) {
      throw ApiException('Invalid response format');
    }

    final responseData = response.data as Map<String, dynamic>;
    
    // 如果不需要解析 data 字段，直接返回整个响应
    if (fromJson == null) {
      return ApiResponse<T>(
        code: responseData['code'] ?? 0,
        msg: responseData['msg'] ?? '',
        data: responseData as T,
      );
    }

    return ApiResponse<T>.fromJson(responseData, fromJson);
  }

  // 统一处理错误
  ApiException _handleDioError(DioException e) {
    if (e.response != null) {
      final responseData = e.response!.data;
      if (responseData is Map<String, dynamic>) {
        return ApiException(
          responseData['msg'] ?? e.message ?? '请求失败',
          code: responseData['code'] ?? e.response?.statusCode,
        );
      }
    }
    
    return ApiException(e.message ?? '网络请求失败', code: e.response?.statusCode);
  }
}
