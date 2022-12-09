import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:abangi_v1/environment.dart';

class CallApi {
  final String _url = apiUrl;

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl + await _getToken();
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  patchData(data, apiUrl) async {
    var fullUrl = _url + apiUrl + await _getToken();
    return await http.patch(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  //delete data
  deleteData(apiUrl) async {
    var fullUrl = _url + apiUrl + await _getToken();
    return await http.delete(Uri.parse(fullUrl), headers: _setHeaders());
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl + await _getToken();
    return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
  }

//set headers accept any
  _setHeaders() =>
      {'Content-type': 'application/json', 'Accept': 'application/json'};
  _getToken() async {
    // ignore: unused_local_variable
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '?token=$token';
  }
}
