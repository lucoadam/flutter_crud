import 'package:flutter/cupertino.dart';
import 'package:resturantapp/models/models.dart';
import 'package:resturantapp/resources/apis/login_api_provider.dart';

class LoginApiRepository {
  final LoginApiProvider loginApiProvider;

  LoginApiRepository({@required this.loginApiProvider})
  : assert(loginApiProvider != null);

  Future<User> authenticateUser(String email, String password) async {
    return loginApiProvider.authenticateUser(email, password);
  }

  Future<User> getCurrentUser() async {
    return loginApiProvider.getCurrentUser();
  }
}