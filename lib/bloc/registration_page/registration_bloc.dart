import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalur/bloc/registration_page/registration_event.dart';
import 'package:jalur/response_api/create_user.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final User user;
  RegistrationBloc({required this.user}) : super(RegistrationInitial()) {
    on<RegistrationSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
    RegistrationSubmitted event,
    Emitter<RegistrationState> emit,
  ) async {
    try {
      emit(RegistrationLoading());
      await user.createUser(
          event.name, event.surname, event.phone, event.gender, event.role, event.age);
      emit(RegistrationSuccess());
    } catch (e) {
      emit(RegistrationFailure(error: e.toString()));
    }
  }
}
