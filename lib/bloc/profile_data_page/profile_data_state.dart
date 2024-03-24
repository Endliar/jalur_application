import '../../models/coach.dart';

abstract class ProfileDataState {}

class InitialState extends ProfileDataState {}

class LoadingProfileDataState extends ProfileDataState {}

class UserLoggedOutState extends ProfileDataState {}

class LoadProfileDataSuccess extends ProfileDataState {
  final List<Coach> users;

  LoadProfileDataSuccess(this.users);
}

class ProfileErrorState extends ProfileDataState {
  final String error;
  ProfileErrorState(this.error);
}
