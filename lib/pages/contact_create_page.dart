import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturantapp/blocs/authentication/authentication.dart';
import 'package:resturantapp/blocs/blocs.dart';
import 'package:resturantapp/blocs/contacts/contact_bloc.dart';
import 'package:resturantapp/blocs/contacts/contact_state.dart';
import 'package:resturantapp/services/authentication_service.dart';
import 'package:resturantapp/services/contact_service.dart';


class ContactCreatePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ContactService>(
      create: (context) {
        return FakeContactService();
      },
      child: BlocProvider<ContactBloc>(
        create: (context) {
          final contactService = RepositoryProvider.of<ContactService>(context);
          return ContactBloc(contactService)..add(ContactFormInitialEvent());
        },
        child: ContactCreate(),
      ),
    );
  }
}
class ContactCreate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Author"),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(8),
        child: BlocBuilder<ContactBloc,ContactState>(
          builder: (context,state){
            print('current state');
            print(state);
            if (state is ContactFormInitial || state is ContactSuccess) {
              return _ContactForm();
            }

            if(state is ContactFormSubmitSuccess){
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


            if (state is ContactFormOnSubmitLoading) {
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            }
            // show error message
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

                      },
                    )
                  ],
                ));
          },
        ),
      )
    );
  }

}



class _ContactForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contactService = RepositoryProvider.of<ContactService>(context);

    return Container(
      alignment: Alignment.center,
      child: BlocProvider<ContactBloc>(
        create: (context) => ContactBloc(contactService),
        child: _SignInForm(),
      ),
    );
  }
}

class _SignInForm extends StatefulWidget {
  @override
  __SignInFormState createState() => __SignInFormState();
}

class __SignInFormState extends State<_SignInForm> {

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileController = TextEditingController();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    final _contactBloc = BlocProvider.of<ContactBloc>(context);

    _onSubmitPressed () {
      print('data');
      print(_key.currentState.validate());
      if (_key.currentState.validate()) {
        _contactBloc.add(ContactFormSubmitEvent(
            email: _emailController.text,
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            mobile: _mobileController.text,
        ));
      }else {
        setState(() {
          _autoValidate = true;
        });
      }
    }
    return BlocListener<ContactBloc, ContactState>(
      listener: (context, state){
        if (state is ContactFormSubmitError){
          _showError(state.error);
        }
      },
      child: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state){
          if (state is ContactFormOnSubmitLoading){
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
                      labelText: 'First Name',
                      isDense: true,
                    ),
                    controller: _firstNameController,
                    validator: (value) {
                      if (value == null || value.length == 0){
                        return 'First Name is required.';
                      }

                      if (value.split(' ').length != 1){
                        return 'First name must be a word';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      isDense: true,
                    ),
                    controller: _lastNameController,
                    validator: (value) {

                      if (value == null){
                        return 'Last Name is required.';
                      }

                      if (value.length==0){
                        return 'Last Name is required.';
                      }

                      if (value.split(' ').length != 1){
                        return 'Last name must be a word';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      isDense: true,
                    ),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (value){
                      if (value == null || value.length == 0){
                        return 'Email is required.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Contact Number',
                    ),
                    controller: _mobileController,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    validator: (value){
                      if (value == null){
                        return 'Contact Number is required.';
                      }
                      if (!(new RegExp(r'^\d{10}$')).hasMatch(value)){
                        return 'It must of 10 digits number.';
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
                    child: Text('Add Author'),
                    onPressed: state is ContactFormOnSubmitLoading ? () {} : _onSubmitPressed,
                  )
                ],
              ),
            ),
          );
        },
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
