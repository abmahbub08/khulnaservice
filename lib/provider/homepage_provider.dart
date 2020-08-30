import 'package:flutter/cupertino.dart';
import 'package:khulnaservice/models/homePageDataModel.dart';

class HomePageProvider extends ChangeNotifier {
  HomePageDataModel homePageData = HomePageDataModel();
  List HeaderBannerList =[];
  setHomeData(value) {
    homePageData = value;
    notifyListeners();
  }

  setHeaderData(value){
    HeaderBannerList=value;
    notifyListeners();
  }
}
