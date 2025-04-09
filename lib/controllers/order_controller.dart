import 'package:get/get.dart';

class OrderController extends GetxController {
  var orderHistoryList = [].obs;
  void updateOrderHistoryList(List<dynamic> orderList) {
    orderHistoryList.assignAll(orderList);
  }
}
