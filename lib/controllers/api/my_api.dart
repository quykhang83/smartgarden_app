import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class CallApi{
  final String _url = 'http://13.213.38.60/api/';
  // final String _imgUrl='http://54.169.139.189/uploads/';
  // getImage(){
  //   return _imgUrl;
  // } code push
  postData(data, apiUrl) async {
    // var fullUrl = _url + apiUrl + await _getToken();
    var fullUrl = _url + apiUrl;
    print(fullUrl);
    return await http.post(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: _setPostHeaders()
    );
  }

  getData(apiUrl) async {
    // var fullUrl = _url + apiUrl + await getToken() ;
    var fullUrl = _url + apiUrl;
    print(fullUrl);

    return await http.get(
        Uri.parse(fullUrl),
        headers: _setGetHeaders1()
    );
  }
  getDataHeader(apiUrl, header) async {
    // var fullUrl = _url + apiUrl + await getToken() ;
    var fullUrl = _url + apiUrl;
    print(fullUrl);

    return await http.get(
        Uri.parse(fullUrl),
        headers: header
    );
  }

  _setPostHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Charset': 'utf-8',
  };

  _setGetHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Charset': 'utf-8',
    'token': '$getToken()',
  };


  _setGetHeaders1() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Charset': 'utf-8',
    'token': 'yRkl2JogHFzLen0daWZM248I2QL2Z89fNCZqNNNOrJVSFEwmR02cVnhGK4q0',
  };


  getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return token;
  }

  deleteToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    var fullUrl = '${_url}logout';
    print(token);
    print(fullUrl);
    var data = {
      'token': token,
    };
    return await http.post(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: _setPostHeaders()
    );
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