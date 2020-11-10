// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturantapp/blocs/book/book_bloc.dart';
import 'package:resturantapp/blocs/book/book_edit_add_toggle_bloc.dart';
import 'package:resturantapp/blocs/book/book_event.dart';
import 'package:resturantapp/resources/apis/book_api_provider.dart';
import 'layouts/layouts.dart';
import 'blocs/blocs.dart';
import 'services/services.dart';
import 'pages/pages.dart';

void main() => runApp(
  // Injects the Authentication service
    RepositoryProvider<AuthenticationService>(
      create: (context) {
        return FakeAuthenticationService();
      },
      // Injects the Authentication BLoC
      child: BlocProvider<AuthenticationBloc>(
        create: (context) {
          final authService = RepositoryProvider.of<AuthenticationService>(context);
          return AuthenticationBloc(authService)..add(AppLoaded());
        },
        child: MyApp(),
      ),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Api App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // BlocBuilder will listen to changes in AuthenticationState
      // and build an appropriate widget based on the state.
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            // show home page
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_)=> BookEditAddToggleBloc(),
                ),
                BlocProvider(
                  create: (_)=> BookBloc()..add(GetAllBookEvent()),
                ),
              ],
              child: Dashboard(user: state.user,),
            );
          }
          // otherwise show welcome page
          return LoginPage();
        },
      ),
    );
  }
}
