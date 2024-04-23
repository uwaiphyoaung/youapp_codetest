import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_code_challenge/app/api/api_response.dart';
import 'package:youapp_code_challenge/app/constants/app.constant.dart';
import 'package:youapp_code_challenge/app/services/account_services.dart';
import 'package:youapp_code_challenge/extensions/string_extension.dart';
import 'package:youapp_code_challenge/models/auth_entity.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AccountService service = AccountService();

  AuthBloc() : super(AuthInitial()) {

    on<AuthEvent>((event, emit) {});

    on<LoginEvent>((event, emit) async {
      emit(ResetState());
      final response = await service.login(event.data);
      if(response is Fail){
        //event.context.catchError(response.error);
        emit(LoginFailState(response.error));
      }
      if(response is Success){
        var data = LoginResponse.fromMap(json.decode(response.data));
        if(data.access_token != null){
          print(data.access_token);
          token = data.access_token.orEmpty();
          emit(LoginSuccessState());
        }else{
          emit(LoginFailState(ApiError(data.message??"Something went wrong",-2)));
        }
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(ResetState());
      final response = await service.register(event.data);
      if(response is Fail){
        emit(RegisterFailState(response.error));
      }
      if(response is Success){
        var data = RegisterResponse.fromMap(json.decode(response.data));
        if(data.message != null){
          emit(RegisterSuccessState(data.message.orEmpty()));
        }else{
          emit(RegisterFailState(null));
        }
      }
    });
  }
}
