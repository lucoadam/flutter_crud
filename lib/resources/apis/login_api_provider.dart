import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:resturantapp/constants/constants.dart';
import 'package:resturantapp/models/models.dart';


class LoginApiProvider {
  final http.Client httpClient;
  String _token;
  String _refreshToken;

  LoginApiProvider({@required this.httpClient}) :
        assert(httpClient != null);

  Future<User> getCurrentUser() async {
    if(_token != null){

    final userResponse = await httpClient.get(
        UrlConstants.getCurrentUser(),
        headers: {
          'authorization': "Bearer "+_token
        }
    );

    if (userResponse.statusCode != 200) {
      print(userResponse.body);
      throw Exception('Sorry, login expired');
    }

    final responseJsonUser = json.decode(userResponse.body);

    responseJsonUser['refresh'] = _refreshToken;
    responseJsonUser['access'] = _token;

    return User.fromJson(responseJsonUser);
    }
    return null;
  }

  Future<User> authenticateUser(String email, String password) async {
    final response = await httpClient.post(
        UrlConstants.getLoginUrl(),
        body: {
          'username': email,
          'password': password
        }
    );
    if (response.statusCode != 200) {
      return null;
      throw Exception('error logging in');
    }

    final responseJson = json.decode(response.body);
    final userResponse = await httpClient.get(
        UrlConstants.getCurrentUser(),
        headers: {
          'authorization': "Bearer "+responseJson['access']
        }
    );

    if (userResponse.statusCode != 200) {
      return null;
      print(userResponse.body);
      throw Exception('error logging in');
    }
    final responseJsonUser = json.decode(userResponse.body);

    responseJsonUser['refresh'] = responseJson['refresh'];
    responseJsonUser['access'] = responseJson['access'];

    _refreshToken = responseJson['refresh'];
    _token = responseJson['access'];

    return User.fromJson(responseJsonUser);
  }
}