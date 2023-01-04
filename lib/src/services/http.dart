import 'dart:convert';

import 'package:http/http.dart' as http;

import '../consts/app_error.dart';

class HttpService {
  Future<dynamic> post(
      {required String uri,
      required Map<String, dynamic> jsonBody,
      required Map<String, String> headers}) async {
    var url = Uri.parse(uri);

    var response =
        await http.post(url, headers: headers, body: jsonEncode(jsonBody));
    var resJson = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return resJson;
    } else {
      throw AppError(resJson["message"], resJson["statusCode"]);
    }
  }

  Future<dynamic> get(
      {required String uri, required Map<String, String> headers}) async {
    var url = Uri.parse(uri);
    var response = await http.get(url, headers: headers);
    var resJson = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return resJson;
    } else {
      throw AppError(resJson["message"], resJson["statusCode"]);
    }
  }
}
