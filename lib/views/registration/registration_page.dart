import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalur/bloc/registration_page/registration_bloc.dart';
import 'package:jalur/bloc/registration_page/registration_event.dart';
import 'package:jalur/helpers/size_config.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../helpers/colors.dart';
import '../../widgets/default_text_field.dart';
import '../../widgets/default_text_header.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late TextEditingController _nameController;

  late TextEditingController _surnameController;

  late TextEditingController _ageController;

  late TextEditingController _phoneController;

  late MaskTextInputFormatter _phoneInputFormatter;

  late TextEditingController _genderController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _surnameController = TextEditingController();
    _ageController = TextEditingController();
    _phoneController = TextEditingController();
    _genderController = TextEditingController();
    _phoneInputFormatter = MaskTextInputFormatter(
      mask: '+# (###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kSecondaryColor,
          title: const Text(
            "Регистрация",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: BlocListener<RegistrationBloc, RegistrationState>(
          listener: (context, state) {
            if (state is RegistrationSuccess) {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Center(
                          child: Text(
                            "Регистрация успешна",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Center(child: Text("Ок")))
                        ],
                      ));
            }
            if (state is RegistrationFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          child: BlocBuilder<RegistrationBloc, RegistrationState>(
            builder: (context, state) {
              if (state is RegistrationLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      headerText("Введите имя"),
                      defaultTextField("Введите ваше имя", _nameController),
                      SizedBox(
                        height: getProportionateScreenHeight(10.0),
                      ),
                      headerText("Введите фамилию"),
                      defaultTextField(
                          "Введите вашу фамилию", _surnameController),
                      SizedBox(
                        height: getProportionateScreenHeight(10.0),
                      ),
                      headerText("Укажите ваш возраст"),
                      defaultTextField("Сколько вам лет?", _ageController),
                      SizedBox(
                        height: getProportionateScreenHeight(10.0),
                      ),
                      headerText("Укажите ваш пол"),
                      defaultTextField("Ваш гендер?", _genderController),
                      headerText("Укажите пол"),
                      SizedBox(
                        height: getProportionateScreenHeight(10.0),
                      ),
                      headerText("Введите номер телефона"),
                      defaultTextField("Ваш номер телефона", _phoneController,
                          maskFormatter: _phoneInputFormatter),
                      SizedBox(
                        height: getProportionateScreenHeight(15.0),
                      ),
                      ElevatedButton(
                          onPressed: state is RegistrationLoading
                              ? null
                              : () {
                                  BlocProvider.of<RegistrationBloc>(context)
                                      .add(RegistrationSubmitted(
                                          name: _nameController.text,
                                          surname: _surnameController.text,
                                          phone: _phoneController.text,
                                          gender: _genderController.text,
                                          age: int.tryParse(
                                                  _ageController.text) ??
                                              0));
                                },
                          child: const Text("Зарегистрироваться"))
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
