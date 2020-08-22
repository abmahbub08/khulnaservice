import 'package:flutter/cupertino.dart';
import 'package:khulnaservice/models/userModel.dart';

class userProvider extends ChangeNotifier {
  UserDataModel userData = UserDataModel();

  addData(value) {
    userData = value;
    notifyListeners();
  }
}
