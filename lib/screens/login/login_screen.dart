import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 通过 Provider 获取 AuthProvider 的实例
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      // appBar: AppBar(title: const Text('Login')),
      body: 
      Center(
        child: ElevatedButton(
          onPressed: () async {
            await authProvider.login('username', 'password');
            if (context.mounted) {
              context.go('/'); // 手动跳转到首页
            }
          },
          child: const Text('模拟登录'),
        ),
      ),
    );
  }
}
