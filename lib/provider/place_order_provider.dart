import 'package:flutter/cupertino.dart';
import 'package:khulnaservice/models/orderListModel.dart';
import 'package:khulnaservice/models/placeOrderModel.dart';
import 'package:khulnaservice/models/searchModel.dart';

class placeOrderProvider extends ChangeNotifier {
  PlaceOrderModel searchData = PlaceOrderModel();
  OrderListModel orderList = OrderListModel();

  addData(value) {
    searchData = value;
    notifyListeners();
  }

  addOrder(value) {
    orderList = value;
    notifyListeners();
  }
}
