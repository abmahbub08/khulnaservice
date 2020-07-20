import 'package:flutter/cupertino.dart';
import 'package:khulnaservice/models/CategoryModel.dart';
import 'package:khulnaservice/models/CategoryPageModel.dart';

class CategoryProvider extends ChangeNotifier {
  CategoryModel myCategory = CategoryModel();

  List<String> tabName = [];
  CategoryPageModel categoryPage = CategoryPageModel();
  CategoryPageModel categoryPageBlank = CategoryPageModel();
  var catSlug;

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

    tabName.add("");
    tabName.add("");

    print(tabName.length);
    notifyListeners();
  }

  getTab() {
    return tabName;
  }



  CategoryPageModel getPage() {
    return categoryPage;
  }
}
