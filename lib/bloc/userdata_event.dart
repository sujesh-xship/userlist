part of 'userdata_bloc.dart';

@immutable
sealed class UserDataEvent {}

class LoaduserDataEvent extends UserDataEvent {
  final int limit;


  LoaduserDataEvent(this.limit, );
}

class LoadAfterUserDataEvent extends UserDataEvent {
  final int limit;
  final int skip;

  LoadAfterUserDataEvent({required this.limit, required this.skip});
}
