import 'package:by_admin_app/services/storage_service.dart';
import 'package:flutter/foundation.dart';

// 混入 ChangeNotifier，让这个类具有通知监听者的能力
class AuthProvider with ChangeNotifier {
  String? _token;

  String? get token => _token;

  /// 判断是否已登录
  bool get isAuth => _token != null;

  // 模拟登录成功，保存 token
  Future<void> login(String username, String password) async {
    // 这里应该调用你的 ApiService 进行登录
    // 假设我们从 API 获取到了一个 token
    _token = 'fake-jwt-token-from-api';
    StorageService.saveString('token', _token!);
    notifyListeners(); // 关键：通知所有监听此 Provider 的 Widget 更新
  }

  void logout() {
    _token = null;
    notifyListeners(); // 关键：通知更新
  }
  Future<void> getToken() async {
    _token = await StorageService.getString('token');
    notifyListeners(); // 关键：通知更新
  }
}