import 'dart:convert';
import 'dart:io';

import 'package:by_admin_app/models/user.dart';
import 'package:by_admin_app/services/storage_service.dart';
import 'package:by_admin_app/services/user_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static MethodChannel platform = MethodChannel(
    'com.example.by_admin_app/battery',
  );
  final UserService _userService = UserService();
  User _info = User();

  String _batteryLevel = 'Unknown battery level.';

  // 获取单次定位
  Future<Map<String, dynamic>?> getCurrentLocation() async {
    try {
      final result = await platform.invokeMethod('getSingleLocation');
      print('获取定位成功:');
      if (result == null) return null;

      // 安全地转换类型
      if (result is Map<Object?, Object?>) {
        return result.cast<String, dynamic>();
      }
      return result as Map<String, dynamic>?;
    } on PlatformException catch (e) {
      print("获取定位失败: ${e.message}");
      return null;
    } on Exception catch (e) {
      print("定位异常: $e");
      return null;
    }
  }

  void _getLocation() async {
    // 检查权限状态
    var status = await Permission.location.status;

    // 如果权限被拒绝或永久拒绝，尝试请求权限
    if (status.isDenied || status.isPermanentlyDenied) {
      status = await Permission.location.request();
    }
    if (status.isGranted) {
      // 权限已获得，执行定位逻辑
      try {
        final location = await getCurrentLocation();
        if (location != null) {
          print('定位成功:');
          print('纬度: ${location['latitude']}');
          print('经度: ${location['longitude']}');
          print('地址: ${location['address']}');
          print('城市: ${location['city']}');
        } else {
          print('获取定位失败');
        }
      } catch (e) {
        print('定位过程出错: $e');
      }
    } else if (status.isPermanentlyDenied) {
      // 用户永久拒绝了权限，引导用户去设置中开启
      print('定位权限被永久拒绝，请在设置中手动开启');
      openAppSettings();
    } else {
      // 权限被拒绝
      print('定位权限被拒绝');
    }
  }

  // 获取电量
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

  Future<String?> _showBottomSheet(BuildContext context) {
    return showModalBottomSheet<String>(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("服务状态", style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              ListTile(
                title: Center(child: Text("在线（可服务）")),
                onTap: () => Navigator.pop(context, "选项一"),
              ),
              ListTile(
                title: Center(child: Text("离线（服务中）")),
                onTap: () => Navigator.pop(context, "选项二"),
              ),
              Divider(height: 1),
              ListTile(
                title: Center(
                  child: Text("取消", style: TextStyle(color: Colors.red)),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
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
                                _buildStatusImage, // 状态图标
                              ],
                            ),
                            InkWell(
                              onTap: () async {
                                final result = await _showBottomSheet(context);
                                if (result != null) {
                                  print("用户选择了: $result");
                                } else {
                                  print("用户取消了");
                                }
                              },
                              child: Row(
                                children: [
                                  _buildStatusIcon, // 状态图标
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
                            ),
                          ],
                        ),
                        Spacer(),
                        InkWell(
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
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 11.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 服务与提现
                  Row(
                    children: [
                      _buildServiceAndWithdrawalCenter('服务更新'),
                      Spacer(),
                      _buildServiceAndWithdrawalCenter('提现中心', 2),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    '资金明细',
                    style: TextStyle(fontSize: 15.sp, color: Color(0xff050100)),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    height: 80.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Colors.white,
                    ),
                    child: GridView.count(
                      crossAxisCount: 4,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      children: [
                        _buildGridItem('收益明细', 'symx.svg'),
                        _buildGridItem('提现记录', 'dsmx.svg'),
                        // _buildGridItem('账户余额'),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    '常用功能',
                    style: TextStyle(fontSize: 15.sp, color: Color(0xff050100)),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    height: 80.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Colors.white,
                    ),
                    child: GridView.count(
                      crossAxisCount: 4,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      children: [
                        _buildGridItem('邀请用户', 'yqyh.svg'),
                        _buildGridItem('邀请伴友', 'yqby.svg'),
                        _buildGridItem('我的二维码', 'qrcode.svg'),
                        _buildGridItem('我的团队', 'team.svg'),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    '其他功能',
                    style: TextStyle(fontSize: 15.sp, color: Color(0xff050100)),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    height: 80.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Colors.white,
                    ),
                    child: GridView.count(
                      crossAxisCount: 4,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      children: [
                        _buildGridItem('紧急联系人', 'jjlxr.svg'),
                        // _buildGridItem('动态管理'),
                        _buildGridItem('帮助中心', 'bz.svg'),
                        _buildGridItem('设置', 'set.svg'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Column(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     ElevatedButton(
            //       onPressed: () => _showBottomSheet(context),
            //       child: Text("打开底部弹窗"),
            //     ),
            //     ElevatedButton(
            //       onPressed: _getBatteryLevel,
            //       child: const Text('Get Battery Level'),
            //     ),
            //     Text(_batteryLevel),
            //     ElevatedButton(
            //       onPressed: _getLocation,
            //       child: const Text('Get Location'),
            //     ),
            //   ],
            // ),
            _buildMapView(),
          ],
        ),
      ),
    );
  }

  // 抽离的网格项组件
  Widget _buildGridItem(String title, [String icon = 'fwgx.svg']) {
    return SizedBox(
      width: 80.w,
      height: 80.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/images/my/$icon', width: 30.w, height: 30.w),
          Text(
            title,
            style: TextStyle(fontSize: 13.sp, color: Color(0xff333333)),
          ),
        ],
      ),
    );
  }

  // 状态图标
  Widget get _buildStatusIcon {
    if (_info.onlineStatus == 2) {
      return SvgPicture.asset(
        'assets/images/my/zx_lv.svg',
        width: 15.w,
        height: 15.w,
      );
    } else {
      return SvgPicture.asset(
        'assets/images/my/lx_h.svg',
        width: 15.w,
        height: 15.w,
      );
    }
  }

  // 状态图标
  Widget get _buildStatusImage {
    if (_info.onlineStatus == 2) {
      return SvgPicture.asset(
        'assets/images/my/zx.svg',
        width: 48.w,
        height: 20.h,
      );
    } else {
      return SvgPicture.asset(
        'assets/images/my/lx.svg',
        width: 48.w,
        height: 20.h,
      );
    }
  }

  // 服务和提现中心
  Widget _buildServiceAndWithdrawalCenter(String title, [int type = 1]) {
    return Container(
      width: 170.w,
      height: 80.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Color(0xffF0F5FF),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18.sp, color: Color(0xff35363A)),
              ),
              SizedBox(height: 11.h),
              Text(
                type == 1 ? '可更新位置和时间' : '方便快捷',
                style: TextStyle(fontSize: 12.sp, color: Color(0xff85868A)),
              ),
            ],
          ),
          type == 2 ? SizedBox(width: 12.w) : SizedBox(),
          SvgPicture.asset(
            'assets/images/my/fwgx.svg',
            width: 46.w,
            height: 46.w,
          ),
        ],
      ),
    );
  }

  // 创建地图视图(已完成✅)
  Widget _buildMapView() {
    return SizedBox(
      height: 300.h,
      child: Builder(
        builder: (context) {
          if (Platform.isAndroid) {
            return AndroidView(
              viewType: 'com.example.by_admin_app/mapview',
              creationParamsCodec: const StandardMessageCodec(),
            );
          } else if (Platform.isIOS) {
            return UiKitView(
              viewType: 'com.example.by_admin_app/mapview',
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
                ),
              },
              creationParamsCodec: const StandardMessageCodec(),
            );
          } else {
            return const Center(child: Text('不支持的平台'));
          }
        },
      ),
    );
  }
}
