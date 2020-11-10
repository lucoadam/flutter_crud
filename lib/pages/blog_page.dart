
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturantapp/blocs/book/book_bloc.dart';
import 'package:resturantapp/blocs/book/book_edit_add_toggle_bloc.dart';
import 'package:resturantapp/blocs/book/book_event.dart';
import 'package:resturantapp/blocs/book/book_state.dart';
import 'package:resturantapp/models/book_model.dart';
import 'package:resturantapp/pages/book_create_page.dart';


class BlogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocListener<BookEditAddToggleBloc,BookModel>(
            listener: (bContext,state){
              BlocProvider.of<BookBloc>(context).add(UpdateStateList());
              if(state!=null){
                  Navigator.push(bContext, MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: BlocProvider.of<BookEditAddToggleBloc>(bContext),
                      child: BlocProvider.value(
                        value: BlocProvider.of<BookBloc>(bContext),
                        child: BookCreatePage(),
                      ),
                  ),
                ),);
              }
            },
            child: BlocBuilder<BookBloc,BookState>(builder: (context, state){
              print(state);
              if(state is OnDataBookState){
                print(state.isAdded);
                print(state.isEdited);
                return ListView.builder(
                  itemCount: state.bookList.length,
                  itemBuilder: (context, position) {
                    return GestureDetector(
                      onTap: (){
                        BlocProvider.of<BookBloc>(context).add(UpdateStateList());
                        BlocProvider.of<BookEditAddToggleBloc>(context).add(BookModel(bookData: state.bookList[position],isEdit: true),);
                      },
                      onLongPress: (){
                        showDialog(
                          context: context,
                          builder: (dContext){
                            return AlertDialog(
                              content: Text('Would you want to delete?'),
                              actions: [
                                FlatButton(
                                  child: Text('Cancel'),
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                ),
                                FlatButton(
                                  child: Text('Delete'),
                                  onPressed: (){
                                    BlocProvider.of<BookBloc>(context).add(DeleteBookEvent(oldData:state.bookList[position]));
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          }
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(state.bookList[position]['title'], style: TextStyle(fontSize: 22.0),),
                        ),
                      ),
                    );
                  },
                );
              }
              if (state is LoadingBookState) {
                return Center(
                  child:CircularProgressIndicator(
                    strokeWidth: 2,
                  ) ,
                );
              }
              return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Sorry, some error ocurred'),
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text('Retry'),
                        onPressed: () {
                          BlocProvider.of<BookBloc>(context).add(GetAllBookEvent());
                        },
                      )
                    ],
                  ));
            },),
    );
  }
}
