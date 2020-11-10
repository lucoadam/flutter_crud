import 'dart:math';

import 'package:resturantapp/resources/apis/contact_api_provider.dart';
import 'package:resturantapp/resources/apis/login_api_provider.dart';
import 'package:resturantapp/resources/repository/contact_api_repository.dart';
import 'package:resturantapp/resources/repository/login_api_repository.dart';

import '../models/models.dart';
import 'package:http/http.dart' as http;

abstract class ContactService {
  Future<List<dynamic>> getContactList();
  Future<String> saveContact(dynamic data);
}

class FakeContactService extends ContactService {
  final ContactApiRepository contactApiRepository = ContactApiRepository(contactApiProvider: ContactApiProvider(
      httpClient: http.Client()
  ));

  @override
  Future<List> getContactList() {
    return contactApiRepository.getContactList();
  }

  @override
  Future<String> saveContact(data) {
    return contactApiRepository.saveContact(data);
  }


}