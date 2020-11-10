
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturantapp/blocs/bottom_navigation_bar/bottom_navigation_event.dart';
import 'package:resturantapp/blocs/bottom_navigation_bar/bottom_navigation_state.dart';

class BottomNavigationBloc extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc(BottomNavigationState initialState) : super(initialState);

  @override
  BottomNavigationState get initialState => BottomNavigationState(2);

  @override
  Stream<BottomNavigationState> mapEventToState(
      BottomNavigationEvent event) async* {
    BottomNavigationState newState;
    newState = BottomNavigationState(event.navigationButtonClickedIndex);
    yield newState;
  }

  changeIndex(int index){
    this.add(BottomNavigationEvent(navigationButtonClickedIndex: index));
  }
}
