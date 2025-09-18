import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tab_provider.dart'; // 假设有一个管理Tab索引的Provider
import '../screens/tabs/home_screen.dart';
import '../screens/tabs/profile_screen.dart';

class TabContainer extends StatelessWidget {
  TabContainer({super.key});

  // 底部导航栏的各个页面
  final List<Widget> _tabPages = <Widget>[
    const HomeScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // 使用Provider获取当前选中的Tab索引
    final currentTabIndex = Provider.of<TabProvider>(context).currentIndex;

    return Scaffold(
      // 当前活动的页面
      body: IndexedStack(
        index: currentTabIndex,
        children: _tabPages,
      ),
      // 底部导航栏
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTabIndex,
        type: BottomNavigationBarType.fixed, // 超过3个Item建议使用fixed
        onTap: (index) {
          // 通过Provider更新索引，触发界面重建
          Provider.of<TabProvider>(context, listen: false).updateIndex(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: '我的',
          ),
        ],
      ),
    );
  }
}