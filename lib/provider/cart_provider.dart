import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:khulnaservice/models/cartListModel.dart';

class CartProvider extends ChangeNotifier {
  var cartLength = Hive.box("myCart").length;
  CartListModel cartList = CartListModel();

  void addCartLength(value) {
    cartLength = Hive.box("myCart").length;
    notifyListeners();
  }

  addCartList(value) {
    cartList = value;
    addAmount();
    notifyListeners();
  }

  int addAmount() {
    int myData = 0;
    cartList.cart.forEach((element) {
      myData = myData + element.price * int.parse(element.quantity.toString());
    });

    return myData;
  }
}
