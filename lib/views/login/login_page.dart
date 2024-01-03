import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalur/bloc/login_page/login_bloc.dart';
import 'package:jalur/bloc/login_page/login_state.dart';
import 'package:jalur/helpers/size_config.dart';
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

  void _sendVerificationCode() {
    if (_phoneInputFormatter.isFill()) {
      setState(() {
        _sendCode = true;
      });
    }
  }

  void _login() {}

  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
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
            } else if (state is LoginSuccessState) {}
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      controller: _phoneController,
                      inputFormatters: [_phoneInputFormatter],
                      decoration: const InputDecoration(
                          hintText: "Введите номер телефона"),
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(16.0),
                    ),
                    _sendCode
                        ? TextField(
                            controller: _smsCodeController,
                            decoration:
                                const InputDecoration(hintText: "Введите код"),
                          )
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
