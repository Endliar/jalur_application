abstract class RegistrationEvent {}

class RegistrationSubmitted extends RegistrationEvent {
  final String name;
  final String surname;
  final String phone;
  final String gender;
  final int age;

  RegistrationSubmitted(
      {required this.name,
      required this.surname,
      required this.phone,
      required this.age,
      required this.gender});
}

abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {}

class RegistrationFailure extends RegistrationState {
  final String error;

  RegistrationFailure({required this.error});
}
