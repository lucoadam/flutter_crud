import 'dart:math';

import 'package:resturantapp/resources/apis/login_api_provider.dart';
import 'package:resturantapp/resources/repository/login_api_repository.dart';

import '../models/models.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationService {
  Future<User> getCurrentUser();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

class FakeAuthenticationService extends AuthenticationService {
  final LoginApiRepository loginApiRepository = LoginApiRepository(loginApiProvider: LoginApiProvider(
      httpClient: http.Client()
  ));

  @override
  Future<User> getCurrentUser() async {

     return loginApiRepository.getCurrentUser();
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    return loginApiRepository.authenticateUser(email, password);
  }

  @override
  Future<void> signOut() {
    return null;
  }
}