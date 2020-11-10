import 'package:flutter/cupertino.dart';

class BottomNavigationEvent {
  final int navigationButtonClickedIndex;
  final DateTime timeStamp;

  BottomNavigationEvent(
      {@required this.navigationButtonClickedIndex, DateTime timeStamp})
      : this.timeStamp = timeStamp ?? DateTime.now();
}
