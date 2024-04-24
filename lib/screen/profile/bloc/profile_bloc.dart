import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_code_challenge/app/api/api_response.dart';
import 'package:youapp_code_challenge/app/services/account_services.dart';
import 'package:youapp_code_challenge/models/profile_entity.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  AccountService service = AccountService();

  ProfileBloc() : super(ProfileInitial()) {

    on<ProfileEvent>((event, emit) {

    });

    on<CreateProfileEvent>((event, emit) async {
      emit(ResetState());
      final response = await service.create(event.data);
      if(response is Fail){
        //service.saveUserData(event.data);
        emit(ProfileCreateFailState(response.error));
      }
      if(response is Success){
        service.saveUserData(event.data);
        emit(ProfileCreateSuccessState());
      }
    });

    on<UpdateProfileEvent>((event, emit) async {
      emit(ResetState());
      final response = await service.update(event.data);
      if(response is Fail){
        //service.saveUserData(event.data);
        emit(ProfileUpdateFailState(response.error));
      }
      if(response is Success){
        service.saveUserData(event.data);
        emit(ProfileUpdateSuccessState());
      }
    });

    on<FetchProfileEvent>((event, emit) async {
      emit(ResetState());
      final response = await service.getProfile();
      if(response is Fail){
        emit(ProfileDataFailState(response.error));
      }
      if(response is Success){
        var data = ProfileCreatePayload.fromMap(json.decode(response.data));
        service.saveUserData(data);
        emit(ProfileDataSuccessState());
      }
    });
  }
}
