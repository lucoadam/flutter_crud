
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturantapp/blocs/book/book_event.dart';
import 'package:resturantapp/blocs/book/book_state.dart';
import 'package:resturantapp/resources/apis/book_api_provider.dart';
import 'package:resturantapp/resources/repository/book_api_repository.dart';
import 'package:http/http.dart' as http;

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookApiRepository _bookApiRepository;

  BookBloc()
      : _bookApiRepository = BookApiRepository(bookApiProvider: BookApiProvider(httpClient: http.Client())) ,
        super(EmptyBookState());
  
  @override
  Stream<BookState> mapEventToState(BookEvent event) async* {
    if(event is UpdateStateList){
      print('update console list');
      yield OnSuccessBookState();
      final bookList = await _bookApiRepository.getBookList();
      yield OnDataBookState(bookList: bookList,isAdded: false,isDeleted: false,isEdited: false);
    }
    else if (event is GetAllBookEvent) {
      yield* mapGetAllBookEventToState();
    } else if (event is AddBookEvent) {
      yield* mapAddBookEventToState(event);
    } else if (event is EditBookEvent) {
      yield* mapEditBookEventToState(event);
    } else if (event is DeleteBookEvent) {
      yield* mapDeleteBookEventToState(event);
    }
  }

  Stream<BookState> mapGetAllBookEventToState() async* {
    yield LoadingBookState();
    try {
      final bookList = await _bookApiRepository.getBookList();
      yield OnDataBookState(bookList: bookList,isAdded: false,isDeleted: false,isEdited: false);
    } catch (e) {
      yield OnErrorBookState(error: 'error: $e');
    }
  }

  Stream<BookState> mapAddBookEventToState(AddBookEvent event) async* {
    yield LoadingBookState();
    try {
      final book = {
        "title": event.formData['title'],
        "author": event.formData['author'],
        "publication": event.formData['publication'],
        "createdAt": DateTime.now().toString(),
      };
      await _bookApiRepository.saveBook(book);
      yield OnSuccessBookState();
      final bookList = await _bookApiRepository.getBookList();
      yield OnDataBookState(bookList: bookList, isAdded: true);

    } catch (e) {
      yield OnErrorBookState(error: 'error: $e');
    }
  }

  Stream<BookState> mapEditBookEventToState(EditBookEvent event) async* {
    yield LoadingBookState();
    try {
      final book = {
        "id": event.oldData["id"],
        "title": event.formData['title'],
        "author": event.formData['author'],
        "publication": event.formData['publication'],
        "createdAt": event.oldData['createdAt'],
        "updatedAt": DateTime.now().toString(),
      };
      await _bookApiRepository.updateBook(book);
      OnSuccessBookState();
      final bookList = await _bookApiRepository.getBookList();
      yield OnDataBookState(bookList: bookList,isAdded: false,isEdited: true);

    } catch (e) {
      yield OnErrorBookState(error: 'error: $e');
    }
  }

  Stream<BookState> mapDeleteBookEventToState(DeleteBookEvent event) async* {
    yield LoadingBookState();
    try {
      await _bookApiRepository.deleteBook(event.oldData);
      yield OnSuccessBookState();
      final bookList = await _bookApiRepository.getBookList();
      yield OnDataBookState(bookList: bookList,isAdded: false,isEdited: false);
    } catch (e) {
      yield OnErrorBookState(error: 'error: $e');
    }
  }
}
