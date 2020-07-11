import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const Base = "https://home2globe.com/ks/public/api/";

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

  Future<http.Response> logUrl(String param, email, password) async {
    try {
      final result = http.post(Base + '$param', body: {
        "email": email,
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
}
