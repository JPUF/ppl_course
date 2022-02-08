import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'exceptions/network_exceptions.dart';


class Api {
  final String _baseUrl = "https://jsonplaceholder.typicode.com";


  Future<dynamic> get(String path) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(_baseUrl + path));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchException('No internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchException(
            'statusCode : ${response.statusCode}');
    }
  }
}