// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static var ip = "http://localhost:9988/api/Student/";
  static String? token;
  //get
  static Future getUser({String code = ""}) async {
    final Uri getUser;
    if (code == "") {
      getUser = Uri.parse("${ip}Get");
    } else {
      getUser = Uri.parse("${ip}Get?code=$code");
    }
    final response = await http.get(getUser,
        headers: {HttpHeaders.authorizationHeader: "Bearer ${token!}"});
    return json.decode(response.body);
  }

  //post
  static Future register(
      {required String code,
      required String name,
      required String pass,
      required String amount}) async {
    int price = int.parse(amount);
    final regisetrUser = Uri.parse(
        "${ip}Register?code=$code&name=$name&password=$pass&amount=$price");
    var response = await http.post(regisetrUser,
        headers: {HttpHeaders.authorizationHeader: "Bearer ${token!}"});
    return response.statusCode;
  }

  static Future Activate({
    required String code,
  }) async {
    final act = Uri.parse("${ip}Activate?code=$code");
    final response = await http.post(act,
        headers: {HttpHeaders.authorizationHeader: "Bearer ${token!}"});
    return response.statusCode;
  }

  static Future deactivate({
    required String code,
  }) async {
    final deact = Uri.parse("${ip}Deactivate?code=$code");
    final response = await http.post(deact,
        headers: {HttpHeaders.authorizationHeader: "Bearer ${token!}"});
    return response.statusCode;
  }

  static Future pay({
    required String code,
    required String amount,
    required String notes,
  }) async {
    int price = int.parse(amount);
    final regisetrUser =
        Uri.parse("${ip}Pay?code=$code&amount=$price&notes=$notes");
    final response = await http.post(regisetrUser,
        headers: {HttpHeaders.authorizationHeader: "Bearer ${token!}"});
    return response.statusCode;
  }

  static Future adminLogin(String code, String password) async {
    final loginUrl = Uri.parse("${ip}AdminLogin?code=$code&password=$password");
    final response = await http.post(loginUrl);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      token = jsonResponse['token'];
    } else {
      token = null;
    }
    return response.statusCode;
  }
}
