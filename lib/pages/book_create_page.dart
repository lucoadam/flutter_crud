import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturantapp/blocs/book/book_bloc.dart';
import 'package:resturantapp/blocs/book/book_edit_add_toggle_bloc.dart';
import 'package:resturantapp/blocs/book/book_event.dart';
import 'package:resturantapp/blocs/book/book_state.dart';
import 'package:resturantapp/models/book_model.dart';


class BookCreatePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BookCreate();
  }
}

class BookCreate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: BlocBuilder<BookEditAddToggleBloc,BookModel>(
        builder: (context, editModel) {
      if(editModel!=null) {
        return Text('Edit Book');
      }
      return Text('Add Book');
      },)
        ),
        body: SafeArea(
          minimum: const EdgeInsets.all(8),
          child: BlocBuilder<BookBloc,BookState>(
            builder: (context,state){
              print('current state');
              print(state);
              if (state is EmptyBookState) {
                return _SignInForm();
              }

              if(state is OnDataBookState ){
                  if(state.isAdded || state.isEdited){
                    return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('Data Submitted successfully'),
                            FlatButton(
                              textColor: Theme.of(context).primaryColor,
                              child: Text('Back'),
                              onPressed: () {
                                Navigator.pop(context);

                              },
                            )
                          ],
                        ));
                  }
              }


              if (state is LoadingBookState) {
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                );
              }
              // show error message
              if (state is OnErrorBookState){
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
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ));
              }
              return _SignInForm();
            },
          ),
        )
    );
  }

}



class _SignInForm extends StatefulWidget {
  @override
  __SignInFormState createState() => __SignInFormState();
}

class __SignInFormState extends State<_SignInForm> {

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _publicationController = TextEditingController();
  final _authorController = TextEditingController();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final _bookBloc = BlocProvider.of<BookBloc>(context);

    _onSubmitPressed () {
      print('data');

      print(_key.currentState.validate());
      if (_key.currentState.validate()) {
        _key.currentState.save();

          _bookBloc.add(AddBookEvent(formData: {
            "title": _titleController.text,
            "publication": _publicationController.text,
            "author": _authorController.text,
          }));

      }else {
        setState(() {
          _autoValidate = true;
        });
      }
    }
    return BlocListener<BookBloc, BookState>(
      listener: (context, state){
        if (state is OnErrorBookState){
          _showError(state.error);
        }
      },
      child: BlocBuilder<BookEditAddToggleBloc,BookModel>(
        builder: (context, editModel) {
          if(editModel!=null){
            print('editModel');
            print(editModel.bookData);
            _titleController.text = editModel.bookData['title'];
            _publicationController.text = editModel.bookData['publication'];
            _authorController.text = editModel.bookData['author'];
          }
          return BlocBuilder<BookBloc, BookState>(
            builder: (context, state){
              if (state is LoadingBookState){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Form(
                key: _key,
                autovalidate: _autoValidate,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Book Title',
                          isDense: true,
                        ),
                        controller: _titleController,
                        validator: (value) {
                          if (value == null || value.length == 0){
                            return 'Title is required.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Publication',
                          isDense: true,
                        ),
                        controller: _publicationController,
                        validator: (value) {

                          if (value == null){
                            return 'Publication is required.';
                          }

                          if (value.length==0){
                            return 'Publication is required.';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Author',
                          isDense: true,
                        ),
                        controller: _authorController,
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        validator: (value){
                          if (value == null || value.length == 0){
                            return 'Author is required.';
                          }
                          if(value.length <=1){
                            return 'Author should be full name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),

                      RaisedButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(16),
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
                        child: editModel!=null?Text('Edit'):Text('Add Book'),
                        onPressed: state is LoadingBookState ? () {} : (){
                          {
                            print('data');

                            print(_key.currentState.validate());
                            if (_key.currentState.validate()) {
                              _key.currentState.save();
                              if(editModel!=null){
                                print(editModel.bookData);
                                _bookBloc.add(EditBookEvent(
                                    formData: {
                                      "title": _titleController.text,
                                      "publication": _publicationController.text,
                                      "author": _authorController.text,
                                    },
                                    oldData: editModel.bookData
                                ));
                              }else {
                                _bookBloc.add(AddBookEvent(formData: {
                                  "title": _titleController.text,
                                  "publication": _publicationController.text,
                                  "author": _authorController.text,
                                }));
                              }
                            }else {
                              setState(() {
                                _autoValidate = true;
                              });
                            }
                          }
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
      ),
    );
  }

  void _showError(String error) {
    Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: Theme.of(context).errorColor,
        )
    );
  }

}
