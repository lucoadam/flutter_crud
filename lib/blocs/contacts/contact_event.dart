// lib/blocs/login/login_event.dart

import 'package:flutter/animation.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ContactEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class LoadContact extends ContactEvent {}

class ContactFormInitialEvent extends ContactEvent {}

class ContactFormSubmitEvent extends ContactEvent {
  final String email;
  final String firstName;
  final String lastName;
  final String mobile;

  ContactFormSubmitEvent({@required this.email, @required this.firstName,@required this.lastName,@required this.mobile});

  @override
  List<Object> get props => [email, firstName,lastName,mobile];
}