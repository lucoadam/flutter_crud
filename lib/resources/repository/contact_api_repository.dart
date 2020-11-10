import 'package:flutter/cupertino.dart';
import 'package:resturantapp/resources/apis/contact_api_provider.dart';

class ContactApiRepository {
  final ContactApiProvider contactApiProvider;

  ContactApiRepository({@required this.contactApiProvider})
  : assert(contactApiProvider != null);

  Future<List<dynamic>> getContactList() async {
    return contactApiProvider.getContactList();
  }

  Future<String> saveContact(data) async {
    return contactApiProvider.saveContact(data);
  }

}