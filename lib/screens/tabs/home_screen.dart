import 'package:by_admin_app/models/dr_list_result.dart';
import 'package:by_admin_app/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final OrderService _orderService = OrderService();
  List<DrListElement> _list = [];

  Future<void> _getList() async {
    final res = await _orderService.daZiList(1, 10);
    if (res != null) {
      setState(() {
        _list = res.list!;
      });
      print('获取列表成功');
    } else {
      print('获取列表失败');
    }
  }

  @override
  void initState() {
    super.initState();
    _getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('我的订单')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.separated(
          itemBuilder: itemBuilder,
          itemCount: _list.length,
          separatorBuilder: (context, index) {
            return SizedBox(height: 12.h); // 设置列间距
          },
        ),
      ),
    );
  }

  /// 列表项
  Widget itemBuilder(BuildContext context, int index) {
    final item = _list[index]; // 提取对象引用
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 订单信息
          Row(
            children: [
              Row(
                children: [
                  Text(
                    '${item.payOrderInfoList?[0].tagName}',
                    style: TextStyle(fontSize: 16.sp, color: Color(0xff020202)),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'x${item.payOrderInfoList?[0].serverTime}h',
                    style: TextStyle(fontSize: 16.sp, color: Color(0xff666666)),
                  ),
                ],
              ),
              Spacer(),
              if (item.payOrderInfoList?[0].serverStatus != null)
                // 状态容器
                _buildStatusContainer(item.payOrderInfoList![0].serverStatus!),
            ],
          ),
          // 分割线
          Container(
            width: double.infinity,
            height: 1.h,
            color: Color.fromRGBO(177, 177, 177, 0.6),
            margin: EdgeInsets.symmetric(vertical: 12.h),
          ),
          Row(
            children: [
              Text(
                '订单编号',
                style: TextStyle(fontSize: 13.sp, color: Color(0xff666666)),
              ),
              Spacer(),
              Text(
                '${item.forderId}',
                style: TextStyle(fontSize: 13.sp, color: Color(0xff020202)),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Text(
                '订单编号',
                style: TextStyle(fontSize: 13.sp, color: Color(0xff666666)),
              ),
              Spacer(),
              Text(
                '${item.forderId}',
                style: TextStyle(fontSize: 13.sp, color: Color(0xff020202)),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Text(
                '订单编号',
                style: TextStyle(fontSize: 13.sp, color: Color(0xff666666)),
              ),
              Spacer(),
              Text(
                '${item.forderId}',
                style: TextStyle(fontSize: 13.sp, color: Color(0xff020202)),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Text(
                '订单编号',
                style: TextStyle(fontSize: 13.sp, color: Color(0xff666666)),
              ),
              Spacer(),
              Text(
                '${item.forderId}',
                style: TextStyle(fontSize: 13.sp, color: Color(0xff020202)),
              ),
            ],
          ),
          SizedBox(height: 26.h),
          Row(
            children: [
              Text(
                '总价${item.payMoney}',
                style: TextStyle(fontSize: 13.sp, color: Color(0xff682525)),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  print('查看订单');
                },
                child: Container(
                  width: 89.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.r),
                    border: Border.all(color: Color(0xff682525)),
                  ),
                  child: Center(
                    child: Text(
                      '查看订单',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Color(0xff682525),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 状态容器
  Widget _buildStatusContainer(int status) {
    final statusText = switch (status) {
      0 => '待接单',
      1 => '待出发',
      2 => '待到达',
      3 => '待服务',
      4 => '服务中',
      5 => '已完成',
      6 => '已取消',
      _ => '',
    };

    if (statusText.isEmpty) return SizedBox.shrink();

    return Container(
      color: Color.fromRGBO(251, 124, 47, 0.1),
      width: 50.w,
      height: 18.h,
      child: Center(
        child: Text(
          statusText,
          style: TextStyle(fontSize: 10.sp, color: Color(0xffFB7C2F)),
        ),
      ),
    );
  }
}
