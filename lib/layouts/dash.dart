// lib/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturantapp/blocs/blocs.dart';
import 'package:resturantapp/pages/pages.dart';
import '../models/models.dart';

class Dashboard extends StatelessWidget {
  final User user;

  const Dashboard({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    final bottomNavigationBloc = BlocProvider.of<BottomNavigationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: buildPageView(bottomNavigationBloc),
      ),
      bottomNavigationBar: buildNavigationBar(bottomNavigationBloc,context),
    );
  }

  Widget buildPageView(BottomNavigationBloc bottomNavigationBloc) {
    return PageView(
      onPageChanged: (index) {
        bottomNavigationBloc.add(BottomNavigationEvent(navigationButtonClickedIndex: index));
      },
      children: <Widget>[
        PreventionPage(),
        BlogPage(),
        MapPage(),
      ],
    );

  }

  Widget buildNavigationBar(BottomNavigationBloc bottomNavigationBloc,BuildContext context) {
    return BlocBuilder<BottomNavigationBloc,BottomNavigationState>(
      builder: (context,state) {
        return BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
            ),
          ],
          currentIndex: state.selectedIndex,

        );
      },
    );
  }
}
