import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class HttpService {
  static final _client = http.Client();
  static var _loginUrl = Uri.parse('https://flaskflutterlogin.herokuapp.com/login');

  static Future<String> login(File img) async {
    var imageBytes=img.readAsBytesSync();
    http.Response response = await _client.post(_loginUrl, body: {
      "image": imageBytes
    });
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var json = jsonDecode(response.body);
        return json[0];
    } else {
      return "hello";
    }
  }
}