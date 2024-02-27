import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../utils/shared_prefrence.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
    on<UserLoginEvent>(userLogin);
  }

  Future<void> userLogin(UserLoginEvent event, Emitter<LoginState> emit) async {
    try {
      // Currently no need to show a loder for the user login
      await SharedPreferencesHelper().setLogin(true);
    } catch (e) {
      print(e);
    } finally {
      emit(LoginSuccessState());
    }
  }
}
