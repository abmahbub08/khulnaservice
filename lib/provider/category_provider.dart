import 'package:flutter/cupertino.dart';
import 'package:khulnaservice/models/CategoryModel.dart';
import 'package:khulnaservice/models/CategoryPageModel.dart';

class CategoryProvider extends ChangeNotifier {
  CategoryModel myCategory = CategoryModel();

  List<String> tabName = [];
  CategoryPageModel categoryPage = CategoryPageModel();
  CategoryPageModel categoryPageBlank = CategoryPageModel();
  var catSlug;
  String maxPrice = "";
  String minPrice = "";

  void addCatData(value) {
    myCategory = value;
    addTabMenu();
    notifyListeners();
  }

  void addCatPageProd(value) {
    categoryPage = value;

    notifyListeners();
  }

  addCatSlug(value) {
    catSlug = value;
    notifyListeners();
  }

  addTabMenu() {
    for (int i = 0; i < myCategory.category.length; i++) {
      tabName.add(myCategory.category[i].name);
    }

    print(tabName.length);
    notifyListeners();
  }

  addMinAndMaxPrice(min, max) {
    minPrice = min;
    maxPrice = max;
    notifyListeners();
  }

  getTab() {
    return tabName;
  }

  CategoryPageModel getPage() {
    return categoryPage;
  }
}
