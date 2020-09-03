import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:khulnaservice/models/cartListModel.dart';

class CartProvider extends ChangeNotifier {
  CartListModel cartList = CartListModel();
  List quantity = [
    {"id": 87, "quantity": 1},
    {"id": 306, "quantity": 1}
  ];

  List qunaModify = [];

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

  addQuantity(ProductID) {
    qunaModify.clear();
    quantity.forEach((element) {
      if (element['id'] == ProductID) {
        element['quantity'] = element['quantity'] + 1;
      } else {
        qunaModify.add({"id": ProductID, "quantity": 2});
      }
    });

    if (qunaModify.length != 0) {
      qunaModify.forEach((element) {
        quantity.add(element);
      });
    }

    var seen = Set<int>();
    var unique = quantity.where((str) => seen.add(str['id'])).toList();
    quantity = unique;
    print(quantity);

    getQuantity(ProductID);
    notifyListeners();
  }

  removeQuantity(ProductID) {
    quantity.forEach((element) {
      if (element['id'] == ProductID) {
        if (element['quantity'] > 1) {
          element['quantity'] = element['quantity'] - 1;
        }
      } else {}
    });

    print(quantity);

    getQuantity(ProductID);
    notifyListeners();
  }

  getQuantity(ProductID) {
    var data;
    quantity.forEach((element) {
      if (element['id'] == ProductID) {
        data = element['quantity'];
      } else {
        // data = 1;
      }
    });

    return data;
  }

  myCartItemQuantityAdd() {
    cartList.cart.forEach((element) {
      quantity.add({"id": element.id, "quantity": element.quantity});
    });

    var seen = Set<int>();
    var unique = quantity.where((str) => seen.add(str['id'])).toList();
    quantity = unique;
    notifyListeners();


  }
}
