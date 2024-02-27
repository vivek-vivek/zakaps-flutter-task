import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/modules/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:flutter_app/modules/dummy_screens/accounts_screen.dart';
import 'package:flutter_app/modules/dummy_screens/home_screen.dart';
import 'package:flutter_app/modules/dummy_screens/search_screen.dart';

part 'bottombar_event.dart';
part 'bottombar_state.dart';

class BottomBarBloc extends Bloc<BottomBarEvent, BottomBarState> {
  BottomBarBloc() : super(BottomBarInitial()) {
    on<BottomBarEvent>((event, emit) {});
    on<ChangeBottomBarTabEvent>(changeTabScreen);
  }

  int selectedTabindex = 1;
  final screenList = const [
    HomeScreen(),
    DashboardScreen(),
    SearchScreen(),
    AccountsScreen()
  ];

  void changeTabScreen(
    ChangeBottomBarTabEvent event,
    Emitter<BottomBarState> emit,
  ) {
    selectedTabindex = event.index;
    emit(TabChangedState(event.index));
  }
}
