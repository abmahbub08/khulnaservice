import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:khulnaservice/models/CategoryModel.dart';
import 'package:khulnaservice/provider/category_provider.dart';
import 'package:provider/provider.dart';
import 'package:khulnaservice/api/repositories.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchData {
  Repositories repositories = Repositories();

  Future geReg(name, email, password) async {
    final regRep = repositories.getRegHttp("register", name, email, password);
    var results = await Future.wait([regRep]);
    SharedPreferences Sp = await SharedPreferences.getInstance();
    if (results[0].statusCode == 200) {
      var data = jsonDecode(results[0].body);
      Sp.setString('token', data['access_token']);
      Sp.setString('user', data['user']);
      print(results[0].body);
      return results[0].body;
    } else {
      throw results[0].body;
    }
  }

  Future getLog(email, password) async {
    final loginRep = repositories.getLoginHttp("login", email, password);
    var results = await Future.wait([loginRep]);
    SharedPreferences Sp = await SharedPreferences.getInstance();
    if (results[0].statusCode == 200) {
      var data = jsonDecode(results[0].body);

      Sp.setString('token', data['access_token']);
      Sp.setString('user', json.encode(['user']));
      print(results[0].body);
      return results[0].body;
    } else {
      throw results[0].body;
    }
  }

  Future getCategory(BuildContext context) async {
    final catRep = repositories.getCategoryHttp("allCategories");
    var results = await Future.wait([catRep]);
    if (results[0].statusCode == 200) {
      Provider.of<CategoryProvider>(context, listen: false)
          .addCatData(categoryModelFromJson(results[0].body));


      return results[0].body;
    } else {
      throw results[0].body;
    }
  }
}
