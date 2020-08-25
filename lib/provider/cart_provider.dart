import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:khulnaservice/models/cartListModel.dart';

class CartProvider extends ChangeNotifier {

  CartListModel cartList = CartListModel();


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
