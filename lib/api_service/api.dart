import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  final String url = "https://8f70-117-219-159-230.ngrok-free.app";

  authData(data, apiUrl) async {
    var fullUrl = url + apiUrl;
    return await http.post(
      Uri.parse(fullUrl),
      body: data,
    );
  }
  postData( apiUrl) async {
    var fullUrl = url + apiUrl;
    return await http.post(
      Uri.parse(fullUrl),
    );
  }
  putData(data, apiUrl) async {
    var fullUrl = url + apiUrl;
    return await http.put(
      Uri.parse(fullUrl),
      body: data,
    );
  }
  putsData( apiUrl) async {
    var fullUrl = url + apiUrl;
    return await http.put(
      Uri.parse(fullUrl),
    );
  }
  getData(apiUrl) async {
    var fullUrl = url + apiUrl;
    // await _getToken();
    return await http.get(
      Uri.parse(fullUrl),
      // headers: _setHeaders()
    );
  }
  deleteData(apiUrl)async{
    var fullUrl = url + apiUrl;
    return await http.delete(
      Uri.parse(fullUrl),
    );
  }
}
