import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class BookEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllBookEvent extends BookEvent {}

class AddBookEvent extends BookEvent {
  final Map<String, dynamic> formData;

  AddBookEvent({@required this.formData});

  @override
  List<Object> get props => [
        formData,
      ];
}

class EditBookEvent extends BookEvent {
  final Map<String, dynamic> formData;
  final Map<String, dynamic> oldData;

  EditBookEvent({
    @required this.formData,
    @required this.oldData,
  });

  @override
  List<Object> get props => [
        formData,
        oldData,
      ];
}

class DeleteBookEvent extends BookEvent {
  final  Map<String, dynamic> oldData;
  DeleteBookEvent({@required this.oldData});

  @override
  List<Object> get props => [oldData];
}

class UpdateStateList extends BookEvent {
}