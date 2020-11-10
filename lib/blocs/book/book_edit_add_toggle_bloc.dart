import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturantapp/models/book_model.dart';

class BookEditAddToggleBloc extends Bloc<BookModel,BookModel>{
  BookEditAddToggleBloc() : super(null);

  @override
  Stream<BookModel> mapEventToState(BookModel event) async*{
    yield event;
  }

}