import 'package:by_admin_app/services/storage_service.dart';
import 'package:flutter/foundation.dart';

// 混入 ChangeNotifier，让这个类具有通知监听者的能力
class AuthProvider with ChangeNotifier {
  String? _token;

  String? get token => _token;

  /// 判断是否已登录
  bool get isAuth => _token != null;

  Future<void> setToken(String token) async {
    _token = token;
    await StorageService.saveString('token', _token!);
    notifyListeners(); // 关键：通知更新
  }
  Future<void> logout() async{
    _token = null;
    await StorageService.remove('token');
    notifyListeners(); // 关键：通知更新
  }
  Future<void> getToken() async {
    _token = await StorageService.getString('token');
    notifyListeners(); // 关键：通知更新
  }
}