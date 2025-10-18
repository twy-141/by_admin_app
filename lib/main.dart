import 'package:flutter/material.dart';
import 'app.dart'; // 导入我们上面创建的 app.dart
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() {
  runApp(
    RefreshConfiguration(
      headerBuilder: () => ClassicHeader(),   // 默认头部
      footerBuilder: () => ClassicFooter(),   // 默认底部
      headerTriggerDistance: 60.0,            // 下拉多少触发刷新
      springDescription: const SpringDescription(
        stiffness: 150, // 刚度，越大回弹越快
        damping: 20,    // 阻尼，越大回弹越稳
        mass: 1.0,      // 质量，越大惯性越强
      ),
      child: MyApp(), // 你的应用
    ),
  ); // 运行应用
}