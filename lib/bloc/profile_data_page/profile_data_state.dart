import '../../response_api/create_user.dart';

abstract class ProfileDataState {}

class InitialState extends ProfileDataState {}

class LoadingProfileDataState extends ProfileDataState {}

class UserLoggedOutState extends ProfileDataState {}

class LoadProfileDataSuccess extends ProfileDataState {
  final List<User> users;

  LoadProfileDataSuccess(this.users);
}

class ProfileErrorState extends ProfileDataState {
  final String error;
  ProfileErrorState(this.error);
}