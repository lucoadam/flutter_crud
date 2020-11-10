// lib/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturantapp/blocs/authentication/authentication.dart';
import 'package:resturantapp/blocs/book/book_bloc.dart';
import 'package:resturantapp/blocs/book/book_edit_add_toggle_bloc.dart';
import 'package:resturantapp/blocs/book/book_event.dart';
import 'package:resturantapp/blocs/bottom_navigation_bar/bottom_navaigation_bloc.dart';
import 'package:resturantapp/blocs/bottom_navigation_bar/bottom_navigation_state.dart';
import 'package:resturantapp/pages/book_create_page.dart';
import 'package:resturantapp/pages/contact_create_page.dart';
import 'package:resturantapp/pages/department_create_page.dart';
import 'package:resturantapp/pages/pages.dart';
import '../models/models.dart';

class Dashboard extends StatelessWidget {
  final User user;

  Dashboard({Key key, @required this.user}) : super(key: key);

  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final headingList = ['Authors', 'Books', 'Departments'];
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return BlocProvider<BottomNavigationBloc>(
      create: (context) => BottomNavigationBloc(BottomNavigationState(0)),
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
            builder: (context, state) {
              return Text(headingList[state.selectedIndex]);
            },
          ),
        ),
        body: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: buildPageView(context),
        ),
        bottomNavigationBar: buildNavigationBar(context),
        floatingActionButton: bulidFloatingActionButton(context),
      ),
    );
  }

  Widget bulidFloatingActionButton(BuildContext context) {
    final datas = ['Author', 'Book', 'Department'];
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (context, state) {
      return FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
          switch (state.selectedIndex) {
            case 0:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ContactCreatePage()));
              break;
            case 1:
              BlocProvider.of<BookBloc>(context).add(UpdateStateList());
              BlocProvider.of<BookEditAddToggleBloc>(context).add(null);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (mContext) => BlocProvider.value(
                    value: BlocProvider.of<BookEditAddToggleBloc>(context),
                      child:BlocProvider.value(
                        value: BlocProvider.of<BookBloc>(context),
                        child: BookCreatePage(),
                      ),
                  ),
                ),
              );
              break;
            case 2:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DepartmentCreatePage()));
              break;
          }
        },
        label: Text(datas[state.selectedIndex]),
        icon: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      );
    });
  }

  Widget buildPageView(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        return PageView(
          onPageChanged: (index) {

            BlocProvider.of<BottomNavigationBloc>(context).changeIndex(index);
          },
          children: <Widget>[
            PreventionPage(),
            BlogPage(),
            MapPage(),
          ],
          controller: _pageController,
        );
      },
    );
  }

  Widget buildNavigationBar(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Authors'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              title: Text('Book'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance),
              title: Text('Department'),
            ),
          ],
          currentIndex: state.selectedIndex,
          onTap: (index) {
            _pageController.jumpToPage(index);
            BlocProvider.of<BottomNavigationBloc>(context).changeIndex(index);
          },
        );
      },
    );
  }
}
