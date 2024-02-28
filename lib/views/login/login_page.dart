import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalur/bloc/home_page/homepage_bloc.dart';
import 'package:jalur/bloc/home_page/homepage_event.dart';
import 'package:jalur/bloc/home_page/homepage_state.dart';
import 'package:jalur/bloc/login_page/login_bloc.dart';
import 'package:jalur/bloc/login_page/login_event.dart';
import 'package:jalur/bloc/login_page/login_state.dart';
import 'package:jalur/helpers/size_config.dart';
import 'package:jalur/response_api/auth_user.dart';
import 'package:jalur/response_api/get_type_workout.dart';
import 'package:jalur/response_api/get_workout.dart';
import 'package:jalur/views/home_page/homepage.dart';
import 'package:jalur/views/login/components/phone_number_input.dart';
import 'package:jalur/views/login/components/verification_code_input.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../helpers/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _sendCode = false;
  late TextEditingController _phoneController;
  final _smsCodeController = TextEditingController();
  late MaskTextInputFormatter _phoneInputFormatter;

  @override
  void initState() {
    super.initState();
    _phoneInputFormatter = MaskTextInputFormatter(
        mask: '+# (###) ###-##-##',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
    _phoneController = TextEditingController();
    _phoneController.addListener(_onPhoneTextChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController.removeListener(_onPhoneTextChanged);
    _phoneController.dispose();
    _smsCodeController.dispose();
  }

  void _onPhoneTextChanged() {}

  void _sendVerificationCode() async {
    final phoneNumber = _phoneController.text;
    if (_phoneInputFormatter.isFill()) {
      try {
        context.read<LoginBloc>().add(SendVerificationCodeEvent(phoneNumber));
        final requestCodeSuccess =
            await context.read<Login>().requestCode(phoneNumber);
        if (requestCodeSuccess) {
          setState(() {
            _sendCode = true;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Ошибка отправки кода верификации")),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Ошибка: $e")));
      }
    }
  }

  void _login() async {
    final smsCode = _smsCodeController.text;
    if (smsCode.isNotEmpty) {
      context
          .read<LoginBloc>()
          .add(LoginWithCodeEvent(_phoneController.text, smsCode));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kSecondaryColor,
          title: const Text(
            "Авторизация",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            } else if (state is LoginSuccessState) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BlocProvider<HomepageBloc>(
                  create: (context) =>
                      HomepageBloc(ApiServiceGetWorkout(), GetTypeWorkout())
                        ..add(LoadWorkoutEvent()),
                  child: BlocBuilder<HomepageBloc, HomepageState>(
                    builder: (context, state) {
                      if (state is LoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is HomepageLoadWorkoutSuccess) {
                        return Homepage(workouts: state.workouts);
                      } else if (state is HomepageErrorState) {
                        return Center(child: Text('Error: ${state.error}'));
                      }
                      return const Center(
                        child: Text('Данные не загружены'),
                      );
                    },
                  ),
                ),
              ));
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    PhoneNumberInput(
                        controller: _phoneController,
                        formatter: _phoneInputFormatter),
                    SizedBox(
                      height: getProportionateScreenHeight(16.0),
                    ),
                    _sendCode
                        ? VerificationCodeInput(controller: _smsCodeController)
                        : SizedBox(
                            height: getProportionateScreenHeight(16.0),
                          ),
                    SizedBox(
                      height: getProportionateScreenHeight(16.0),
                    ),
                    ElevatedButton(
                        onPressed: state is LoginLoadingState
                            ? null
                            : _sendCode
                                ? _login
                                : _sendVerificationCode,
                        child: state is LoginLoadingState
                            ? const CircularProgressIndicator()
                            : Text(_sendCode ? "Войти" : "Отправить код"))
                  ],
                ),
              );
            },
          ),
        ));
  }
}
