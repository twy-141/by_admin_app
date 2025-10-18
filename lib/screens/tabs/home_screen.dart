import 'package:by_admin_app/models/dr_list_result.dart';
import 'package:by_admin_app/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final OrderService _orderService = OrderService();
  List<DrListElement> _list = []; // 列表数据
  int _pageNum = 1; // 当前页码
  final int _pageSize = 3; // 每页数量
  bool _hasMore = true; // 是否还有更多
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  Future<void> _getList() async {
    final res = await _orderService.daZiList(_pageNum, _pageSize);
    if (res != null) {
      setState(() {
        if (_pageNum == 1) {
          _list = res.list ?? [];
        } else {
          _list.addAll(res.list ?? []);
        }
        // 更安全的分页计算
        if (res.total != null && res.list != null) {
          final totalPage = (res.total! / _pageSize).ceil();
          _hasMore = _pageNum < totalPage;
        } else {
          _hasMore = false;
        }
      });
      print('获取列表成功');
    } else {
      print('获取列表失败');
    }
  }

  void _onRefresh() async {
    setState(() {
      _pageNum = 1; // 重置为第一页
    });
    await _getList();
    _refreshController.refreshCompleted(); // 完成刷新
    _refreshController.resetNoData(); // 重置为无更多数据
  }

  void _onLoading() async {
    if (_hasMore) {
      setState(() {
        _pageNum++;
      });
      await _getList();
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
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
      body: SmartRefresher(
        controller: _refreshController,
        enablePullUp: true,
        enablePullDown: true,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        header: ClassicHeader(
          releaseText: '下拉刷新',
          completeText: '刷新完成',
          idleText: '下拉刷新',
          refreshingText: '正在刷新...',
          failedText: '刷新失败',
        ),
        footer: CustomFooter(
          builder: (context, mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text('上拉加载');
            } else if (mode == LoadStatus.loading) {
              body = Text('加载中...');
            } else if (mode == LoadStatus.failed) {
              body = Text('加载失败');
            } else if (mode == LoadStatus.canLoading) {
              body = Text('松手开始加载');
            } else {
              // LoadStatus.noMore
              body = Text('没有更多数据');
            }
            return SizedBox(height: 55.0, child: Center(child: body));
          },
        ),
        child: ListView.separated(
          padding: EdgeInsets.all(12.0), // 在这里加内边距
          itemBuilder: itemBuilder,
          itemCount: _list.length,
          separatorBuilder: (context, index) {
            return SizedBox(height: 12.h);
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
              InkWell(
                onTap: () {
                  // 导航到订单详情页面
                  GoRouter.of(context).push('/orderDetail?orderId=${item.forderId}');
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
