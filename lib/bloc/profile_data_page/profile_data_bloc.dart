import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalur/bloc/profile_data_page/profile_data_event.dart';
import 'package:jalur/response_api/user_logout.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'profile_data_state.dart';

class ProfileDataBloc extends Bloc<ProfilehDataEvent, ProfileDataState> {
  ProfileDataBloc() : super(InitialState()) {
    on<UserLogoutEvent>(_onUserLogoutEvent);
  }

  void _onUserLogoutEvent(UserLogoutEvent event, Emitter<ProfileDataState> emit) async {
    try {
      emit(LoadingProfileDataState());

      final SharedPreferences preferences = await SharedPreferences.getInstance();
      final int? userId = preferences.getInt('user_id');

      final UserLogout _getUserData = UserLogout();
      await _getUserData.userLogout(userId);

      await preferences.remove('auth_token');
      await preferences.remove('user_id');

      emit(UserLoggedOutState());

    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }
}
