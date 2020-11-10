import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:resturantapp/constants/constants.dart';


class BookApiProvider {
  final http.Client httpClient;

  BookApiProvider({@required this.httpClient}) :
        assert(httpClient != null);


  Future<List<dynamic>> getBookList() async {
    final response = await httpClient.get(UrlConstants.getBookUrl());
    if (response.statusCode != 200) {
      throw Exception('error loading books');
    }

    final responseJson = json.decode(response.body);

    return responseJson;
  }

  Future<String> saveBook(dynamic data) async {
    final response = await httpClient.post(UrlConstants.getBookUrl(),body: json.encode(data));
    if (response.statusCode != 200) {
      throw Exception('error saving book');
    }
    print(response.body);
    return response.body;
  }

  Future<String> updateBook(dynamic data) async {
    final response = await httpClient.put(UrlConstants.getBookUrl(),body: json.encode(data));
    if (response.statusCode != 200) {
      throw Exception('error loading contact');
    }
    print('response');
    print(response.body);
    return response.body;
  }

  Future<String> deleteBook(dynamic data) async {
    print('post data');
    print(data['id']);
    final response = await httpClient.delete(UrlConstants.getBookUrl()+'&id='+data['id'].toString());
    print(response.statusCode);
    if (response.statusCode != 200) {
      print(response.body);
      throw Exception('error loading contact');
    }
    print('response');
    print(response.body);
    return response.body;
  }
}