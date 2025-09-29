import 'package:by_admin_app/models/dr_list_result.dart';
import 'package:by_admin_app/services/api_service.dart';

class OrderService {
  final ApiService _api = ApiService();

  /// 订单列表
  Future<DrListResult?> daZiList(int pageNum, int pageSize) async {
    try {
      final response = await _api.post<DrListResult>(
        '/wxapi/payOrder/daZiList',
        data: {'pageNum': pageNum, 'pageSize': pageSize},
        fromJson: (data) => DrListResult.fromJson(data),
      );
      if (response.success) {
        final data = response.data!;
        
        return data;
      } else {
        print('获取列表失败: ${response.msg}');
        return null;
      }
    } on ApiException catch (e) {
      print('代码异常: $e');
      return null;
    }
  }
}
