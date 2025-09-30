import 'package:by_admin_app/models/user.dart';
import 'package:by_admin_app/services/storage_service.dart';
import 'package:flutter/foundation.dart';

// 混入 ChangeNotifier，让这个类具有通知监听者的能力
class AuthProvider with ChangeNotifier {
  String? _token;

  String? get token => _token;

  User? _userInfo;

  User? get userInfo => _userInfo;

  /// 判断是否已登录
  bool get isAuth => _token != null;

  Future<void> setToken(String token) async {
    _token = token;
    await StorageService.saveString('token', _token!);
    notifyListeners(); // 关键：通知更新
  }

  Future<void> setUserInfo(dynamic info) async {
    if (info is Map<String, dynamic>) {
      _userInfo = User.fromJson(info); // 将 map 转换为 User 实例
    } else {
      _userInfo = info as User?; // 如果已经是 User 类型，则直接赋值
    }
    await StorageService.saveObject('userInfo', info);
    await StorageService.saveObject('userInfo', info);
    notifyListeners(); // 关键：通知更新
  }

  Future<void> logout() async {
    _token = null;
    await StorageService.remove('token');
    notifyListeners(); // 关键：通知更新
  }

  Future<void> getToken() async {
    _token = await StorageService.getString('token');
    notifyListeners(); // 关键：通知更新
  }
}
