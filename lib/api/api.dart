import 'dart:convert';

import 'package:http/http.dart' as http;

class CallApi{
    final String _url = 'https://home2globe.com/ks/public/api/';

    postData(data, apiUrl) async {
        var fullUrl = _url + apiUrl;
        return await http.post(
          fullUrl,
          body: jsonEncode(data),
          headers:  _setHeaders()
        );
    }

    getData(apiUrl) async {
        var fullUrl = _url + apiUrl;
        return await http.get(
          fullUrl,
          headers: _setHeaders()
        );
    }

    _setHeaders() => {
      'content-type' : 'application/json',
      'Accept' : 'application/json'
    };



  //-----with token
    postDataToken(data, apiUrl, token) async {
      var fullUrl = _url + apiUrl;
      return await http.post(
        fullUrl,
        body: jsonEncode(data),
        headers:  _setHeadersToken(token)
      );
    }

    getDataToken(apiUrl, token) async {
        var fullUrl = _url + apiUrl;
        return await http.get(
          fullUrl,
          headers: _setHeadersToken(token)
        );
    }

    _setHeadersToken(token) => {
      'content-type' : 'application/json',
      'Accept' : 'application/json',
      'Authorization' : token
    };

    
}




