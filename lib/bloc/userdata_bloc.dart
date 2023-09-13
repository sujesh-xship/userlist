import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:user_details/model/detail.dart';
import 'package:user_details/model/user_data.dart';
import 'package:user_details/service/service.dart';

part 'userdata_event.dart';
part 'userdata_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  final NetworkService networkService;
  UserDataBloc(this.networkService) : super(UserDataInitialState()) {
    on<LoaduserDataEvent>((event, emit) async {
      print("event called");
      final userdata = await networkService.userData(event.limit,0);
      // final userDetails = await networkService.userDetails();
      emit(UserDataLoadedState(userData: userdata));
    });

    on<LoadAfterUserDataEvent>((event, emit) async {
      print("after loading event called");
      final userdata = await networkService.userData(event.limit,event.skip);
      print("data length>>...${userdata!.limit}");
      emit(UserDataLoadedState(
        userData: userdata,
      ));
    });
  }
}
