import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class BookState extends Equatable {
  @override
  List<Object> get props => [];
}

class EmptyBookState extends BookState {}

class LoadingBookState extends BookState {}

class OnSuccessBookState extends BookState {}

class OnDataBookState extends BookState {
  final List<dynamic> bookList;
  final bool isAdded;
  final bool isEdited;
  final bool isDeleted;
  OnDataBookState({@required this.bookList, this.isAdded = false, this.isEdited=false, this.isDeleted =  false,});

  @override
  List<Object> get props => [bookList];
}

class OnErrorBookState extends BookState {
  final String error;
  OnErrorBookState({@required this.error});

  @override
  List<Object> get props => [error];
}
