import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class CallApi{
  final String _url = 'http://13.213.44.119/api/';
  // final String _imgUrl='http://54.169.139.189/uploads/';
  // getImage(){
  //   return _imgUrl;
  // }
  postData(data, apiUrl) async {
    // var fullUrl = _url + apiUrl + await _getToken();
    var fullUrl = _url + apiUrl;
    print(fullUrl);
    return await http.post(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl + await getToken() ;
    return await http.get(
        Uri.parse(fullUrl),
        headers: _setHeaders()
    );
  }

  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Charset': 'utf-8',
  };

  getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return token;
  }


  // getArticles(apiUrl) async {
  //
  // }


  getPublicData(apiUrl) async {
    http.Response response = await http.get(
      Uri.parse(_url+apiUrl));
    try{
      if(response.statusCode == 200){
        return response;
      } else {
        return 'failed';
      }
    } catch (e) {
      print(e);
      return 'failed';
    }
  }

}