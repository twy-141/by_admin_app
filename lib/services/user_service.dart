// 导入必要的包
import 'package:by_admin_app/models/user.dart';
import 'package:by_admin_app/services/api_service.dart';

class UserService {
  final ApiService _api = ApiService();

  // 1. 获取用户信息
  Future<User?> getUserProfile(int userId) async {
    try {
      final response = await _api.get<User>(
        '/user/profile', // 你的API端点
        queryParameters: {'id': userId}, // 查询参数
        fromJson: (data) => User.fromJson(data), // 使用你的User模型
      );

      if (response.success) {
        return response.data;
      } else {
        print('获取用户信息失败: ${response.msg} (code: ${response.code})');
        return null;
      }
    } on ApiException catch (e) {
      print('API异常: $e');
      return null;
    }
  }

  // 2. 更新用户信息
  Future<bool> updateUserProfile(User user) async {
    try {
      final response = await _api.post<User>(
        '/user/update',
        data: user.toJson(), // 将User对象转换为JSON
        fromJson: (data) => User.fromJson(data),
      );

      return response.success;
    } on ApiException catch (e) {
      print('更新用户信息失败: $e');
      return false;
    }
  }

  // 3. 登录接口示例
  Future<User?> login(String account, String password) async {
    try {
      final response = await _api.post<User>(
        '/wxapi/loginDaRen/account',
        data: {
          'account': account,
          'password': password,
        },
        fromJson: (data) => User.fromJson(data),
      );
      if (response.success) {
        // 登录成功，保存token等操作
        final user = response.data!;
        // if (user.token != null) {
        //   // 保存token到本地存储
        //   await StorageService.setString('token', user.token!);
        // }
        return user;
      } else {
        print('登录失败: ${response.msg}');
        return null;
      }
    } on ApiException catch (e) {
      print('登录异常: $e');
      return null;
    }
  }

  // 4. 获取用户列表（如果API支持）
  Future<List<User>> getUsers({int page = 1, int limit = 20}) async {
    try {
      final response = await _api.get<List<User>>(
        '/users',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
        fromJson: (data) => (data as List).map((e) => User.fromJson(e)).toList(),
      );

      if (response.success) {
        return response.data ?? [];
      } else {
        print('获取用户列表失败: ${response.msg}');
        return [];
      }
    } on ApiException catch (e) {
      print('获取用户列表异常: $e');
      return [];
    }
  }
}
