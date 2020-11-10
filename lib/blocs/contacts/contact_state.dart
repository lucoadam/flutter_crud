// lib/blocs/login/login_state.dart

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


abstract class ContactState extends Equatable{
@override
List<Object> get props => [];
}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactSuccess extends ContactState {
  final List<dynamic> contacts;

  ContactSuccess({@required this.contacts});

  @override
  List<Object> get props => contacts;
}

class ContactFailure extends ContactState {
  final String error;

  ContactFailure({@required this.error});

  @override
  List<Object> get props => [error];
}

class ContactFormInitial extends ContactState {}

class ContactFormSubmit extends ContactState {}

class ContactFormOnSubmitLoading extends ContactState {}

class ContactFormSubmitSuccess extends ContactState {}

class ContactFormSubmitError extends ContactState {
  final String error;

  ContactFormSubmitError({@required this.error});

  @override
  List<Object> get props => [error];
}

