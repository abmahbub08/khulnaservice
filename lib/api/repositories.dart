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
}
