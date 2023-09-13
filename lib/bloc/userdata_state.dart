part of 'userdata_bloc.dart';

@immutable
sealed class UserDataState {}

final class UserDataInitialState extends UserDataState {}

final class UserDataLoadedState extends UserDataState {
  final UserData? userData;
  // final UserDetails? userDetails;

  UserDataLoadedState({
    required this.userData,
    // required this.userDetails,
  });
}

final class UserDataErrorState extends UserDataState {}
