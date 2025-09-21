import 'package:by_admin_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final UserService _userService = UserService();
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  // 卸载时释放资源
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if(_loading) return;
    if (_formKey.currentState?.validate() ?? false) {
       setState(() => _loading = true);
       final loginResponse = await _userService.login(_usernameController.text, _passwordController.text);
       if (loginResponse != null) {
        //  GoRouter.of(context).push('/home');
       } else {
         print('登录失败');
       }
       setState(() => _loading = false);
    } else {
      // 如果表单验证失败，显示错误信息
      // 登录接口
      // final loginResponse = await _api.post<User>(
      //   '/auth/login',
      //   data: {'account': 'user123', 'password': 'password123'},
      //   fromJson: (data) => User.fromJson(data),
      // );

      // final authProvider = Provider.of<AuthProvider>(context, listen: false);
      // await authProvider.login(
      //   _usernameController.text,
      //   _passwordController.text,
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SizedBox(
        width: 100.sw,
        height: 100.sh,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/login_bg.png',
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: SizedBox(
                width: 300.w,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '密码登录',
                        style: TextStyle(
                          fontSize: 28.sp,
                          color: const Color(0xFF333333),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: '用户名',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '请输入用户名';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: '密码',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '请输入密码';
                          }
                          if (value.length < 6) {
                            return '密码长度至少6位';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30.h),
                      ElevatedButton(onPressed: _login, child: Text('登录')),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
