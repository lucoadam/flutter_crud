import 'package:flutter/cupertino.dart';
import 'package:resturantapp/resources/apis/book_api_provider.dart';

class BookApiRepository {
  final BookApiProvider bookApiProvider;

  BookApiRepository({@required this.bookApiProvider})
  : assert(bookApiProvider != null);

  Future<List<dynamic>> getBookList() async {
    return bookApiProvider.getBookList();
  }

  Future<String> saveBook(data) async {
    return bookApiProvider.saveBook(data);
  }

  Future<String> updateBook(data) async {
    return bookApiProvider.updateBook(data);
  }

  Future<String> deleteBook(data) async {
    return bookApiProvider.deleteBook(data);
  }

}