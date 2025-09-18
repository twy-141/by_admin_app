import 'package:by_admin_app/services/storage_service.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://qmdzapi.qunmeng.club/', // 你的 API 地址
      connectTimeout: const Duration(seconds: 5000), // 连接超时时间
      receiveTimeout: const Duration(seconds: 3000), // 接收超时时间
    ),
  );

  // 添加拦截器（例如统一添加 token）
  ApiService() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // 从本地存储获取token并添加到请求头
          final token = await StorageService.getString('token');
          if (token != null) {
            options.headers['Authorization'] = token;
          }
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          // 检查返回数据中的code字段是否为401
          final responseData = response.data;
          if (responseData is Map && responseData['code'] == 401) {
            // 清除本地token
            await StorageService.remove('token');

            // 可以在这里跳转到登录页或抛出异常
            // 抛出一个自定义的DioException来触发错误处理
            final error = DioException(
              requestOptions: response.requestOptions,
              response: response,
              error: 'Authentication failed: code 401',
              type: DioExceptionType.badResponse,
            );
            return handler.reject(error);
          }
          return handler.next(response);
        },

        onError: (DioException e, handler) async {
          // 处理401未授权错误
          if (e.response?.statusCode == 401) {
            // 清除本地token
            await StorageService.remove('token');

            // 这里可以跳转到登录页
            // 需要获取navigator context，可以通过全局navigatorKey
            // Navigator.of(navigatorKey.currentContext!).pushReplacementNamed('/login');

            // 或者抛出特定异常让调用方处理
            return handler.reject(e);
          }
          return handler.next(e);
        },
      ),
    );
  }
}
