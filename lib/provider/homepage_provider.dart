import 'package:flutter/cupertino.dart';
import 'package:khulnaservice/models/homePageDataModel.dart';

class HomePageProvider extends ChangeNotifier {
  HomePageDataModel homePageData = HomePageDataModel();

  setHomeData(value) {
    homePageData = value;
    notifyListeners();
  }
}
