import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const Base = "https://app.khulnaservice.com/api/";
var imageLink = "https://khulnaservice.com/";
var paymentUrl = "https://app.khulnaservice.com/";

class ApiServices {
  Future<http.Response> regUrl(String param, name, email, password) async {
    try {
      final result = http.post(Base + '$param', body: {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": password
      });
      return result;
    } catch (e) {
      throw Exception();
    }
  }

  Future<http.Response> regWithPhone(
      String param, name, phone, password) async {
    try {
      final result = http.post(Base + '$param', body: {
        "name": name,
        "phone": "+88$phone",
        "password": password,
      });
      return result;
    } catch (e) {
      throw Exception();
    }
  }

  Future<http.Response> logUrl(String param, method, email, password) async {
    try {
      final result = http.post(Base + '$param', body: {
        "$method": email,
        "password": password,
        "password_confirmation": password
      });
      return result;
    } catch (e) {
      throw Exception();
    }
  }

  Future<http.Response> categoryUrl(String param) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      final result = http.get(Base + '$param', headers: {
        "Authorization": "Bearer ${sharedPreferences.get("token")}",
        "content-type": "application/json",
        "Accept": "application/json"
      });
      return result;
    } catch (e) {
      throw Exception();
    }
  }

  Future<http.Response> categoryPage(String param) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      final result = http.get(Base + '$param', headers: {
        "Authorization": "Bearer ${sharedPreferences.get("token")}",
        "content-type": "application/json",
        "Accept": "application/json"
      });
      return result;
    } catch (e) {
      throw Exception();
    }
  }

//  HomePage
  Future<http.Response> homepageRes(String param) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      final result = http.get(Base + '$param', headers: {
        "Authorization": "Bearer ${sharedPreferences.get("token")}",
        "content-type": "application/json",
        "Accept": "application/json"
      });
      return result;
    } catch (e) {
      throw Exception();
    }
  }

//  add To Cart
  Future<http.Response> addToCart(String param, productID, quantity) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      final result = http.post(Base + '$param', body: {
        "product_id": productID,
        "quantity": quantity
      }, headers: {
        "Authorization": "Bearer ${sharedPreferences.get("token")}",
        "Accept": "application/json"
      });
      return result;
    } catch (e) {
      throw Exception();
    }
  }

  Future<http.Response> cartGet(String param) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      final result = http.get(Base + '$param', headers: {
        "Authorization": "Bearer ${sharedPreferences.get("token")}",
        "Accept": "application/json"
      });
      return result;
    } catch (e) {
      throw Exception();
    }
  }

  Future<http.Response> deleteCart(String param) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      final result = http.delete(Base + '$param', headers: {
        "Authorization": "Bearer ${sharedPreferences.get("token")}",
        "Accept": "application/json"
      });
      return result;
    } catch (e) {
      throw Exception();
    }
  }

  Future<http.Response> updateCart(String param, quantity) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      final result = http.put(Base + '$param', body: {
        "quantity": quantity
      }, headers: {
        "Authorization": "Bearer ${sharedPreferences.get("token")}",
        "Accept": "application/json"
      });
      return result;
    } catch (e) {
      throw Exception();
    }
  }

  Future<http.Response> addressUpdate(String param, phone, address1, address2,
      stateID, cityID, addressType, makeAddressSame) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      final result = http.put(Base + '$param', body: {
        "phone": phone,
        "address_1": address1,
        "address_2": address2,
        "state_id": stateID,
        "city_id": cityID,
        "address_type": addressType,
        "country_code": "BD",
        "make_addresses_same": makeAddressSame,
      }, headers: {
        "Authorization": "Bearer ${sharedPreferences.get("token")}",
        "Content-Type": "application/x-www-form-urlencoded"
      });
      return result;
    } catch (e) {
      throw Exception();
    }
  }

  Future<http.Response> getPlaceOrderData(String param) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      final result = http.get(Base + '$param', headers: {
        "Authorization": "Bearer ${sharedPreferences.get("token")}",
        "Accept": "application/json",
      });
      return result;
    } catch (e) {
      throw Exception();
    }
  }

  Future<http.Response> searchGet(String param) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      final result = http.get(Base + '$param', headers: {
        "Authorization": "Bearer ${sharedPreferences.get("token")}",
        "Accept": "application/json"
      });
      return result;
    } catch (e) {
      throw Exception();
    }
  }

  Future<http.Response> CheckoutRes(
      String param, name, notes, paymentMethod) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      final result = http.post(Base + '$param', body: {
        "name": name,
        "notes": notes,
        "payment_method": paymentMethod
      }, headers: {
        "Authorization": "Bearer ${sharedPreferences.get("token")}",
        "Accept": "application/json"
      });
      return result;
    } catch (e) {
      throw Exception();
    }
  }

  Future<http.Response> getOrderList(String param) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      final result = http.get(Base + '$param', headers: {
        "Authorization": "Bearer ${sharedPreferences.get("token")}",
        "Accept": "application/json"
      });
      return result;
    } catch (e) {
      throw Exception();
    }
  }

  Future<http.Response> nameUpdate(String param, name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      final result = http.put(Base + '$param', body: {
        "name": name,
        "is_deactivated": 0.toString(),
      }, headers: {
        "Authorization": "Bearer ${sharedPreferences.get("token")}",
        "Content-Type": "application/x-www-form-urlencoded"
      });
      return result;
    } catch (e) {
      throw Exception();
    }
  }

  Future<http.Response> couponRes(String param, coupon) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      final result = http.post(Base + '$param', body: {
        "Coupon": coupon
      }, headers: {
        "Authorization": "Bearer ${sharedPreferences.get("token")}",
      });
      return result;
    } catch (e) {
      throw Exception();
    }
  }

  Future<http.Response> profileData(String param) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      final result = http.get(Base + '$param', headers: {
        "Authorization": "Bearer ${sharedPreferences.get("token")}",
      });
      return result;
    } catch (e) {
      throw Exception();
    }
  }

  Future<http.Response> sendOtp(String param, referral, phone) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      final result = http.post(Base + '$param', body: {
        "referral": referral,
        "phone": phone
      }, headers: {
        "Authorization": "Bearer ${sharedPreferences.get("token")}",
      });
      return result;
    } catch (e) {
      throw Exception();
    }
  }

  Future<http.Response> verifyOTP(String param, phone, OTP) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      final result = http.post(Base + '$param', body: {
        "phone": phone,
        "otp": OTP
      }, headers: {
        "Authorization": "Bearer ${sharedPreferences.get("token")}",
      });
      return result;
    } catch (e) {
      throw Exception();
    }
  }

  Future<http.Response> individualOrder(String param) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      final result = http.get(Base + '$param', headers: {
        "Authorization": "Bearer ${sharedPreferences.get("token")}",
      });
      return result;
    } catch (e) {
      throw Exception();
    }
  }
}
