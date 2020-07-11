import 'package:flutter/cupertino.dart';
import 'package:khulnaservice/models/CategoryModel.dart';

class CategoryProvider extends ChangeNotifier {
  CategoryModel myCategory = CategoryModel();
  List<String> tabName = [];

  void addCatData(value) {
    myCategory = value;
    addTabMenu();
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
}
