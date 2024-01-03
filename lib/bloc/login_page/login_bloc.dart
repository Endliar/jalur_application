import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalur/bloc/login_page/login_event.dart';
import 'package:jalur/bloc/login_page/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialState()) {
    on<SendVerificationCodeEvent>((event, emit) async {
      if (event.phoneNumber != null && event.phoneNumber!.isNotEmpty) {
        emit(CodeSentState());
      } else {
        emit(LoginErrorState("Не указан номер телефона"));
      }
    });
    on<LoginWithCodeEvent>((event, emit) async {
      if (event.smsCode != null && event.smsCode!.isNotEmpty) {
        emit(LoginSuccessState());
      } else {
        emit(LoginErrorState("Не указан SMS код"));
      }
    });
  }
}
