import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalur/bloc/login_page/login_event.dart';
import 'package:jalur/bloc/login_page/login_state.dart';

import '../../response_api/auth_user.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login loginRepo;
  LoginBloc({required this.loginRepo}) : super(InitialState()) {
    on<SendVerificationCodeEvent>((event, emit) async {
      if (event.phoneNumber != null && event.phoneNumber!.isNotEmpty) {
        try {
          emit(LoginLoadingState());
          bool requestCodeSent = await loginRepo.requestCode(event.phoneNumber!);
          if (requestCodeSent) {
            emit(CodeSentState());
          } else {
            emit(LoginErrorState("Не удалось отправить код верификации"));
          }
        } catch (e) {
          emit(LoginErrorState(e.toString()));
        }
      } else {
        emit(LoginErrorState("Не указан номер телефона"));
      }
    });
    on<LoginWithCodeEvent>((event, emit) async {
      if (event.smsCode != null && event.smsCode!.isNotEmpty) {
        try {
          emit(LoginLoadingState());
          bool isAuth = await loginRepo.authUser(event.phoneNumber!, event.smsCode!);
          if (isAuth == true) {
            emit(LoginSuccessState());
          } else {
            emit(LoginErrorState("Введен неверный код"));
          }
        } on Exception catch (e) {
          emit(LoginErrorState(e.toString()));
        }
      } else {
        emit(LoginErrorState("Не указан SMS код"));
      }
    });
  }
}
