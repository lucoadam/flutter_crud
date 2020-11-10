import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturantapp/blocs/contacts/contact_bloc.dart';
import 'package:resturantapp/blocs/contacts/contact_event.dart';
import 'package:resturantapp/blocs/contacts/contact_state.dart';
import 'package:resturantapp/services/contact_service.dart';


class PreventionPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ContactService>(
      create: (context) {
        return FakeContactService();
      },
      child: BlocProvider<ContactBloc>(
        create: (context) {
          final contactService = RepositoryProvider.of<ContactService>(context);
          return ContactBloc(contactService)..add(LoadContact());
        },
        child: ContactPage(),
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

      return BlocBuilder<ContactBloc,ContactState>(
        builder: (context,state){
          if (state is ContactSuccess) {

            final filterData = [];
            state.contacts.forEach((data){

              if(data!=null && data['firstName']!=null){
                filterData.add(data);
              }
            });

            return  ListView.builder(
              itemCount: filterData.length,
              itemBuilder: (context, position) {
                return GestureDetector(
                  onTap: (){
                    // BlocProvider.of<BookEditAddToggleBloc>(context).add(BookModel(bookData: state.bookList[position],isEdit: true),);
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
                                  // BlocProvider.of<BookBloc>(context).add(DeleteBookEvent(oldData:state.bookList[position]));
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
                      child: Text(filterData[position]['firstName'], style: TextStyle(fontSize: 22.0),),
                    ),
                  ),
                );
              },
            );
          }
          if (state is ContactFailure){
            return  Container(
              child: Center(
                child: Text('Falied to load'),
              ),
            );
          }
          if (state is ContactLoading){
            return  Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          }
          return  Container(
            child: Center(
              child: Text(' Contact Page'),
            ),
          );
        },
      );

  }



}
