import 'api_services.dart';
import 'package:http/http.dart' as http;

class Repositories {
  ApiServices apiService = ApiServices();

  Future<http.Response> getRegHttp(String param, name, email, password) {
    try {
      return apiService.regUrl(param, name, email, password);
    } catch (e) {
      throw Exception();
    }
  }

  Future<http.Response> getLoginHttp(String param, email, password) {
    try {
      return apiService.logUrl(param, email, password);
    } catch (e) {
      throw Exception();
    }
  }

  Future<http.Response> getCategoryHttp(String param) {
    try {
      return apiService.categoryUrl(param);
    } catch (e) {
      throw Exception();
    }
  }

  Future<http.Response> getCatPageHttp(String param) {
    try {
      return apiService.categoryPage(param);
    } catch (e) {
      throw Exception();
    }
  }

//  HomePage
  Future<http.Response> getHomePageHttp(String param) {
    try {
      return apiService.homepageRes(param);
    } catch (e) {
      throw Exception();
    }
  }

//addToCart
  Future<http.Response> getAddToCartHttp(String param, productID, quantity) {
    try {
      return apiService.addToCart(param, productID, quantity);
    } catch (e) {
      throw Exception();
    }
  }

  Future<http.Response> getCartList(String param) {
    try {
      return apiService.cartGet(param);
    } catch (e) {
      throw Exception();
    }
  }

  Future<http.Response> deleteCart(String param) {
    try {
      return apiService.deleteCart(param);
    } catch (e) {
      throw Exception();
    }
  }

  Future<http.Response> updateCart(String param, quantity) {
    try {
      return apiService.updateCart(param, quantity);
    } catch (e) {
      throw Exception();
    }
  }

  Future<http.Response> placeOrderHttp(String param) {
    try {
      return apiService.getPlaceOrderData(param);
    } catch (e) {
      throw Exception();
    }
  }

  Future<http.Response> addressUpdateHttp(String param, phone, address1,
      address2, stateID, cityID, addressType, makeAddressSame) {
    try {
      return apiService.addressUpdate(param, phone, address1, address2, stateID,
          cityID, addressType, makeAddressSame);
    } catch (e) {
      throw Exception();
    }
  }

  Future<http.Response> searchGetHttp(String param) {
    try {
      return apiService.searchGet(param);
    } catch (e) {
      throw Exception();
    }
  }

  Future<http.Response> checkOutHttp(String param, name, notes, paymentMethod) {
    try {
      return apiService.CheckoutRes(param, name, notes, paymentMethod);
    } catch (e) {
      throw Exception();
    }
  }

  Future<http.Response> orderListRes(String param) {
    try {
      return apiService.getOrderList(param);
    } catch (e) {
      throw Exception();
    }
  }
}
