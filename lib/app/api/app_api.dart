import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:youapp_code_challenge/app/constants/app.constant.dart';

import 'api_response.dart';

class API {

  Client client = Client();

  Map<String, String> headerWithAuth() => {
    "Accept": "application/json",
    "content-type": "application/json",
    "x-access-token": 'Bearer $token',
  };

  Map<String, String> headers = {
    "Accept": "application/json",
    "content-type": "application/json"
  };

  Future<ApiResponse> get(String url) async {
    if (kDebugMode) {
      print("calling -> $url");
    }
    try {
      var response = await client.get(
          Uri.parse(url),
          headers: headers);
      if (kDebugMode) {
        print(
            "response for these API $url -> ${response.statusCode} ${json.decode(utf8.decode(response.bodyBytes))}");
      }
      switch (response.statusCode) {
        case 200:
        case 201:
          return Success(response.body);
        default:
          return Fail(ApiError("Something went wrong", response.statusCode));
      }
    } on SocketException {
      return Fail(ApiError("Connection Lost!", -1));
    } on Exception catch (e) {
      return Fail(ApiError("Something went wrong", -2));
    }
  }


  Future<ApiResponse> postBodyWithoutAuth(String url, dynamic objString) async {
    if (kDebugMode) {
      print("calling => $url");
      print("obj => $objString");
    }
    try {
      final response = await client.post(Uri.parse(url),
          headers: headers,
          body: json.encode(objString),
          encoding: Encoding.getByName("utf-8"));
      if (kDebugMode) {
        print(
            "response for these API $url -> ${response.statusCode} ${json.decode(utf8.decode(response.bodyBytes))}");
      }
      switch (response.statusCode) {
        case 200:
        case 201:
          return Success(response.body);
        default:
          return Fail(ApiError(response.body, response.statusCode));
      }
    } on SocketException {
      return Fail(ApiError("Internet Connection Lost", -1));
    } on Exception catch (e) {
      return Fail(ApiError("Something went wrong", -2));
    }
  }

  Future<ApiResponse> postBody(String url, dynamic objString) async {
    if (kDebugMode) {
      print("calling => $url");
      print("obj => $objString");
    }
    try {
      final response = await client.post(Uri.parse(url),
          headers: headerWithAuth(),
          body: json.encode(objString),
          encoding: Encoding.getByName("utf-8"));
      if (kDebugMode) {
        print("token => $token");
        print(
            "response for these API $url -> ${response.statusCode} ${json.decode(utf8.decode(response.bodyBytes))}");
      }
      switch (response.statusCode) {
        case 200:
        case 201:
          return Success(response.body);
        case 401:
          return Fail(ApiError("No token provided.", 401));
        default:
          return Fail(ApiError(response.body, response.statusCode));
      }
    } on SocketException {
      return Fail(ApiError("Internet Connection Lost", -1));
    } on Exception catch (e) {
      return Fail(ApiError("Something went wrong", -2));
    }
  }

  Future<ApiResponse> putBody(String url, dynamic objString) async {
    if (kDebugMode) {
      print("calling => $url");
      print("obj => $objString");
    }
    try {
      final response = await client.put(Uri.parse(url),
          headers: headerWithAuth(),
          body: json.encode(objString),
          encoding: Encoding.getByName("utf-8"));
      if (kDebugMode) {
        print(
            "response for these API $url -> ${response.statusCode} ${json.decode(utf8.decode(response.bodyBytes))}");
      }
      switch (response.statusCode) {
        case 200:
        case 201:
          return Success(response.body);
        case 401:
          return Fail(ApiError("No token provided.", 401));
        default:
          return Fail(ApiError(response.body, response.statusCode));
      }
    } on SocketException {
      return Fail(ApiError("Internet Connection Lost", -1));
    } on Exception catch (e) {
      return Fail(ApiError("Something went wrong", -2));
    }
  }
}
