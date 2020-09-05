import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:khulnaservice/api/api_services.dart';
import 'package:khulnaservice/models/CategoryModel.dart';
import 'package:khulnaservice/models/CategoryPageModel.dart';
import 'package:khulnaservice/models/cartListModel.dart';
import 'package:khulnaservice/models/homePageDataModel.dart';
import 'package:khulnaservice/models/orderListModel.dart';
import 'package:khulnaservice/models/placeOrderModel.dart';
import 'package:khulnaservice/models/profiledatamodel.dart';
import 'package:khulnaservice/models/userModel.dart';
import 'package:khulnaservice/provider/cart_provider.dart';
import 'package:khulnaservice/provider/category_provider.dart';
import 'package:khulnaservice/provider/homepage_provider.dart';
import 'package:khulnaservice/provider/place_order_provider.dart';
import 'package:khulnaservice/provider/profile_data_provider.dart';
import 'package:khulnaservice/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:khulnaservice/api/repositories.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:khulnaservice/provider/search_provider.dart';
import 'package:khulnaservice/models/searchModel.dart';
import 'package:http/http.dart' as http;

class FetchData {
  Repositories repositories = Repositories();

  Future geReg(context, name, email, password) async {
    final regRep = repositories.getRegHttp("register", name, email, password);
    var results = await Future.wait([regRep]);
    SharedPreferences Sp = await SharedPreferences.getInstance();
    if (results[0].statusCode == 200) {
      var data = jsonDecode(results[0].body);
      Sp.setString('token', data['access_token']);
      Sp.setString('name', data['name']);
      Sp.setString('email', email);
      Sp.setString('password', password);
      Provider.of<userProvider>(context, listen: false)
          .addData(userDataModelFromJson(results[0].body));
      return results[0].body;
    } else {
      throw results[0].body;
    }
  }

  Future getRegPhone(context, name, phone, password) async {
    final regRep =
        repositories.getRegPhoneHttp("register", name, phone, password);
    var results = await Future.wait([regRep]);
    SharedPreferences Sp = await SharedPreferences.getInstance();
    if (results[0].statusCode == 200) {
      var data = jsonDecode(results[0].body);

      print(data);
      Sp.setString('token', data['access_token']);
      Sp.setString('name', data['name']);
      Sp.setString('email', phone);
      Sp.setString('password', password);
      Provider.of<userProvider>(context, listen: false)
          .addData(userDataModelFromJson(results[0].body));
      return results[0].body;
    } else {
      throw results[0].body;
    }
  }

  Future getLog(context, method, email, password) async {
    final loginRep =
        repositories.getLoginHttp("login", method, email, password);
    var results = await Future.wait([loginRep]);
    SharedPreferences Sp = await SharedPreferences.getInstance();
    if (results[0].statusCode == 200) {
      var data = jsonDecode(results[0].body);

      Sp.setString('token', data['access_token']);
      Sp.setString('name', data['name']);
      Sp.setString('email', email);
      Sp.setString('password', password);
      Provider.of<userProvider>(context, listen: false)
          .addData(userDataModelFromJson(results[0].body));
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

  Future getCatPage(
      BuildContext context, slug, minPrice, maxPrice, index, keyword) async {
    final catRep = repositories.getCatPageHttp(
        "cat-products/$slug?min_price=$minPrice&max_price=$maxPrice&page=$index&search_keyword=$keyword");
    var results = await Future.wait([catRep]);
    if (results[0].statusCode == 200) {
//      print(results[0].body);
      Provider.of<CategoryProvider>(context, listen: false)
          .addCatPageProd(categoryPageModelFromJson(results[0].body));

      return results[0].body;
    } else {
      throw results[0].body;
    }
  }

//  HomePage
  Future getHomePageData(BuildContext context) async {
    final catRep = repositories.getCategoryHttp("homeProducts");
    var results = await Future.wait([catRep]);
    if (results[0].statusCode == 200) {
      var data = jsonDecode(results[0].body);
      List myList = [];
      data['header_key'].values.toList().forEach((e) {
        if (data["ecommerceSetting"]['$e']['link'] == null) {
          print(data["ecommerceSetting"]['$e']);

          myList.add(data["ecommerceSetting"]['$e']['image']);
        }
      });
      print(data['header_key']);
      Provider.of<HomePageProvider>(context, listen: false)
          .setHeaderData(myList);
      Provider.of<HomePageProvider>(context, listen: false)
          .setHomeData(homePageDataModelFromJson(results[0].body));
      return results[0].body;
    } else {
      throw results[0].body;
    }
  }

//  addToCart
  Future getAddToCart(productID, quantity) async {
    final catRep =
        repositories.getAddToCartHttp("addtocart", productID, quantity);
    var results = await Future.wait([catRep]);
    if (results[0].statusCode == 200) {
      return results[0].body;
    } else {
      throw results[0].body;
    }
  }

  Future getCart(context) async {
    final catRep = repositories.getCartList("cart");
    var results = await Future.wait([catRep]);
    if (results[0].statusCode == 200) {
      print(results[0].body);
      Provider.of<CartProvider>(context, listen: false)
          .addCartList(cartListModelFromJson(results[0].body));
      return results[0].body;
    } else {
      throw results[0].body;
    }
  }

  Future deleteCart(context, productID) async {
    final catRep = repositories.deleteCart("removeitem/$productID");
    var results = await Future.wait([catRep]);
    if (results[0].statusCode == 200) {
      print(results[0].body);
      return results[0].body;
    } else {
      throw results[0].body;
    }
  }

  Future updateCart(context, productID, quantity) async {
    final catRep = repositories.updateCart("updateCart/$productID", quantity);
    var results = await Future.wait([catRep]);
    if (results[0].statusCode == 200) {
      print(results[0].body);
      return results[0].body;
    } else {
      throw results[0].body;
    }
  }

  Future getPlaceOrderData(context) async {
    final catRep = repositories.placeOrderHttp("placeOrder");
    var results = await Future.wait([catRep]);
    if (results[0].statusCode == 200) {
      print(results[0].body);
      Provider.of<placeOrderProvider>(context, listen: false)
          .addData(placeOrderModelFromJson(results[0].body));

      return results[0].body;
    } else {
      print(results[0].body);
      throw results[0].body;
    }
  }

  Future addressUpdate(context, phone, address1, address2, stateID, cityID,
      addressType, makeAddressSame) async {
    final catRep = repositories.addressUpdateHttp("addressUpdate", phone,
        address1, address2, stateID, cityID, addressType, makeAddressSame);
    var results = await Future.wait([catRep]);
    if (results[0].statusCode == 200) {
      print(results[0].body);
      return results[0].body;
    } else {
      throw results[0].body;
    }
  }

  Future searchData(context, keyword, index, minPrice, maxPrice) async {
    final catRep = repositories.searchGetHttp(
        "products?search_keyword=$keyword&page=$index&min_price=$minPrice&max_price=$maxPrice");
    var results = await Future.wait([catRep]);
    if (results[0].statusCode == 200) {
      Provider.of<searchProvider>(context, listen: false)
          .addSearch(searchModelFromJson(results[0].body));
      return results[0].body;
    } else {
      throw results[0].body;
    }
  }

  Future checkOut(context, name, notes, paymentMethod) async {
    final catRep =
        repositories.checkOutHttp("checkout", name, notes, paymentMethod);
    var results = await Future.wait([catRep]);
    if (results[0].statusCode == 200) {
      print(results[0].body);
      return results[0].body;
    } else {
      throw results[0].body;
    }
  }

  Future OrderList(context) async {
    final catRep = repositories.orderListRes("allOrders");
    var results = await Future.wait([catRep]);
    if (results[0].statusCode == 200) {
      var data = jsonDecode(results[0].body);

      Provider.of<placeOrderProvider>(context, listen: false)
          .addOrder(orderListModelFromJson(results[0].body));
      return data;
    } else {
      throw results[0].body;
    }
  }

  Future nameUpdate(name) async {
    final catRep = repositories.nameUpdateHttp("profileUpdate", name);
    var results = await Future.wait([catRep]);
    if (results[0].statusCode == 200) {
      print(results[0].body);
      return results[0].body;
    } else {
      throw results[0].body;
    }
  }

  Future imageUpdate(filepath) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      "Authorization": "Bearer ${sharedPreferences.get("token")}",
      "Content-Type": "application/x-www-form-urlencoded"
    };
    var url = Base + "info";
    var request =
        http.MultipartRequest("PUT", Uri.parse("${Base}profileImageUpdate"));
    request.files.add(await http.MultipartFile.fromPath('Image', filepath));
    request.headers.addAll(headers);

    var response = await request.send();
    if (response.statusCode == 200) {
      print(response);
      return "success";
    } else {
      throw "error";
    }
  }

  Future coupon(coupon) async {
    final catRep = repositories.couponHttp("profileUpdate", coupon);
    var results = await Future.wait([catRep]);
    if (results[0].statusCode == 200) {
      print(results[0].body);
      return results[0].body;
    } else {
      throw results[0].body;
    }
  }

  Future profileData(context) async {
    final catRep = repositories.profileHttp("profile");
    var results = await Future.wait([catRep]);
    if (results[0].statusCode == 200) {
      Provider.of<ProfileDataProvider>(context, listen: false)
          .addDaa(profileDataModelFromJson(results[0].body));
      return results[0].body;
    } else {
      throw results[0].body;
    }
  }

  Future sendOTP(referral, phone) async {
    final catRep = repositories.sendOTPHttp("sendOTP", referral, phone);
    var results = await Future.wait([catRep]);
    if (results[0].statusCode == 200) {
      print(results[0].body);
      return results[0].body;
    } else {
      throw results[0].body;
    }
  }

  Future verifyOTP(phone, OTP) async {
    final catRep = repositories.otpVerify("verifyOTP", phone, OTP);
    var results = await Future.wait([catRep]);
    if (results[0].statusCode == 200) {
      print(results[0].body);
      return results[0].body;
    } else {
      throw results[0].body;
    }
  }

  Future IndividualOrder(orderID) async {
    final catRep = repositories.IndividualOrder("showOrder/$orderID");
    var results = await Future.wait([catRep]);
    if (results[0].statusCode == 200) {
      print(results[0].body);
      return results[0].body;
    } else {
      throw results[0].body;
    }
  }
}
