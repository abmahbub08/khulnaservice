import 'package:flutter/cupertino.dart';
import 'package:khulnaservice/models/searchModel.dart';

class searchProvider extends ChangeNotifier {
  SearchModel searchData = SearchModel();

  addSearch(value) {
    searchData = value;
    notifyListeners();
  }
}
