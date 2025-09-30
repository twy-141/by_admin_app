import 'dart:convert';

import 'package:by_admin_app/models/user.dart';
import 'package:by_admin_app/services/storage_service.dart';
import 'package:by_admin_app/services/user_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const platform = MethodChannel('com.example.by_admin_app/battery');
  final UserService _userService = UserService();
  User _info = User();

  String _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final result = await platform.invokeMethod<int>('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  Future<void> _getInfo() async {
    // 读取存储的对象
    final storedUserInfo = await StorageService.getObject('userInfo');

    if (storedUserInfo != null) {
      // 访问对象属性
      final daziId = storedUserInfo['daziId'];
      final res = await _userService.getUserInfo(daziId);
      if (res != null) {
        setState(() {
          _info = res;
        });
        print('获取用户信息成功');
        // print(jsonEncode(_info));
      } else {
        print('获取用户信息失败');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 头部
            Container(
              width: double.infinity,
              height: 227.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/my/bg.webp'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 11.w, right: 11.w),
                child: Column(
                  children: [
                    SizedBox(height: 70.h),
                    Row(
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: _info.avatar ?? '',
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            width: 62.w,
                            // 设置固定宽度
                            height: 62.w,
                            // 设置固定高度（与宽度相同）
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // 设置列的元素居左对齐
                          children: [
                            Row(
                              children: [
                                Text(
                                  _info.nickname ?? '',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Color(0xff050100),
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                if (_info.onlineStatus == 2)
                                  SvgPicture.asset(
                                    'assets/images/my/zx.svg',
                                    width: 48.w,
                                    height: 20.h,
                                  ),
                                if (_info.onlineStatus == 0)
                                  SvgPicture.asset(
                                    'assets/images/my/lx.svg',
                                    width: 48.w,
                                    height: 20.h,
                                  ),
                              ],
                            ),
                            Row(
                              children: [
                                if (_info.onlineStatus == 2)
                                  SvgPicture.asset(
                                    'assets/images/my/zx_lv.svg',
                                    width: 15.w,
                                    height: 15.w,
                                  ),
                                if (_info.onlineStatus == 0)
                                  SvgPicture.asset(
                                    'assets/images/my/lx_h.svg',
                                    width: 15.w,
                                    height: 15.w,
                                  ),
                                Text(
                                  _info.onlineStatus == 2
                                      ? '在线 (可服务)'
                                      : '离线 (服务中)',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Color(0xff54504D),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            // context.go('/editProfile');
                          },
                          child: SvgPicture.asset(
                            'assets/images/my/arrow-right.svg',
                            width: 32.w,
                            height: 32.w,
                          ),
                        ),
                        SizedBox(width: 12.w),
                      ],
                    ),
                    Spacer(),
                    Container(
                      width: double.infinity,
                      height: 64.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        child: Row(
                          children: [
                            Text(
                              '当前登录城市：',
                              style: TextStyle(
                                color: Color(0xff050100),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '郑州市',
                              style: TextStyle(
                                color: Color(0xff682525),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text('测试'),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _getBatteryLevel,
                  child: const Text('Get Battery Level'),
                ),
                Text(_batteryLevel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
