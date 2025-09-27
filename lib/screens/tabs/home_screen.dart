import 'package:by_admin_app/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  final OrderService _orderService = OrderService();

  Future<void> _getList() async {
   final res = await _orderService.daZiList(1,10);
    if (res != null) {
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
      appBar: AppBar(
        title: const Text('我的订单'),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Text('未登录!'),
      ),
    );
  }
}