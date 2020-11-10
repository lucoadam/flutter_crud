// lib/blocs/login/login_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:resturantapp/services/contact_service.dart';
import 'contact_event.dart';
import 'contact_state.dart';
import '../../exceptions/exceptions.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactService _contactService;

  ContactBloc(ContactService contactService)
      :  assert(contactService != null),
        _contactService = contactService,
        super(ContactInitial());

  @override
  Stream<ContactState> mapEventToState(ContactEvent event) async* {

    if (event is ContactFormInitialEvent){
      yield ContactFormInitial();
    }

    if (event is ContactFormSubmitEvent){

      String result = await _contactService.saveContact({
        "firstName":event.firstName,
        "lastName":event.lastName,
        "email":event.email,
        "mobile":event.mobile
      });

      print('result');
      print(result);
      if(result != null && result != 'error') {
        print('result1');
        yield ContactFormSubmitSuccess();
      } else {
        yield ContactFormSubmitError(error: 'Something very weird just happened');
      }

    }

    if (event is LoadContact) {
      yield* _mapContactToState(event);
    }


  }



  Stream<ContactState> _mapContactToState(LoadContact event) async* {
    yield ContactLoading();
    try {
      final contacts = await _contactService.getContactList();
      if (contacts != null) {
        yield ContactInitial();
        yield ContactSuccess(contacts: contacts);

      } else {
        yield ContactFailure(error: 'Something very weird just happened');
      }
    } on AuthenticationException catch (e) {
      yield ContactFailure(error: e.message);
    } catch (err) {
      yield ContactFailure(error: err.message ?? 'An unknown error occured');
    }
  }
}


