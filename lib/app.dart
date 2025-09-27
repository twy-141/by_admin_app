import 'package:by_admin_app/providers/tab_provider.dart';
import 'package:by_admin_app/tab_container.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'providers/auth_provider.dart';
import 'screens/login/login_screen.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // 定义路由
  final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return TabContainer();
        },
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
    ],
    // 路由重定向逻辑（例如：根据登录状态跳转）
    redirect: (BuildContext context, GoRouterState state) async {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.getToken();
      final bool isLoggedIn = authProvider.isAuth;
      final bool goingToLogin = state.uri.path == '/login';

      // 如果未登录且当前不在登录页，则跳转到登录页
      if (!isLoggedIn && !goingToLogin) {
        return '/login';
      }
      // 如果已登录且当前在登录页，则跳转到首页
      if (isLoggedIn && goingToLogin) {
        return '/';
      }
      // 其他情况保持不变
      return null;
    },
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // 在应用的顶层提供我们所需的 Provider
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TabProvider()),
        // 可以继续添加其他 Provider
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812), // 使用 iPhone 13 的设计尺寸
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp.router(
            title: '伴友之家',
            theme: ThemeData(
              scaffoldBackgroundColor: Color(0xffF8F9FD),
              primarySwatch: Colors.blue, // 设置主题颜色
              splashColor: Colors.transparent, // 去除水波纹效果
              highlightColor: Colors.transparent, // 去除高亮效果
            ),
            routerConfig: _router, // 使用 GoRouter 的路由配置
          );
        },
      ),
    );
  }
}