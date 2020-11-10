import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  final Widget child;
  final Function() onPressed;
  CustomFloatingButton({@required this.child, @required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: child,
      onPressed: onPressed,
    );
  }
}
