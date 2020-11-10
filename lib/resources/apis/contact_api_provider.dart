import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:resturantapp/constants/constants.dart';
import 'package:resturantapp/models/models.dart';


class ContactApiProvider {
  final http.Client httpClient;

  ContactApiProvider({@required this.httpClient}) :
        assert(httpClient != null);


  Future<List<dynamic>> getContactList() async {
    final response = await httpClient.get(UrlConstants.getContactUrl());
    if (response.statusCode != 200) {
      throw Exception('error loading contact');
    }

    final responseJson = json.decode(response.body);

    return responseJson;
  }

  Future<String> saveContact(dynamic data) async {
    print('post data');
    print(data);
    final response = await httpClient.post(UrlConstants.getContactUrl(),body: json.encode(data));
    if (response.statusCode != 200) {
      throw Exception('error loading contact');
    }
    print('response');
    print(response.body);
    return response.body;
  }
}