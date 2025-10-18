import 'package:by_admin_app/models/da_ren_info_result.dart';
import 'package:by_admin_app/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final OrderService _orderService = OrderService();
  DaRenInfoResult _orderDetail = DaRenInfoResult();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 初始化订单详情
    _initOrderDetail();
  }

  /// 初始化订单详情
  Future<void> _initOrderDetail() async {
    final orderId = GoRouterState.of(context).uri.queryParameters['orderId'];
    if (orderId != null) {
      final detail = await _orderService.payOrderInfo(orderId);
      if (detail != null) {
        setState(() {
          _orderDetail = detail;
        });
      } else {
        // 处理获取详情失败的情况
        Fluttertoast.showToast(
          msg: '获取订单详情失败',
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0.sp,
        );
      }
    }
  }

  /// 复制订单编号
  void _copyOrderId() {
    if (_orderDetail.forderId != null) {
      Clipboard.setData(ClipboardData(text: _orderDetail.forderId!)); // 复制订单编号到剪贴板
      Fluttertoast.showToast(
        msg: '复制订单编号成功',
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0.sp,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('订单详情')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 17.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('订单编号: ${_orderDetail.forderId ?? 'N/A'}' ,style: TextStyle(fontSize: 14.sp, color: Color(0xff333333))),
                  SizedBox(width: 10.w,),
                  InkWell(
                    onTap: () => _copyOrderId(),
                    child: SvgPicture.asset('assets/images/order/copy.svg' , fit: BoxFit.cover, width: 40.w, height: 18.h),
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
