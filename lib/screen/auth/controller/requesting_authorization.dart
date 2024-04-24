import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_code_challenge/extensions/context_extension.dart';
import 'package:youapp_code_challenge/extensions/dialog.extension.dart';
import 'package:youapp_code_challenge/models/auth_entity.dart';
import 'package:youapp_code_challenge/screen/auth/bloc/auth_bloc.dart';
import 'package:youapp_code_challenge/screen/profile/profile_screen.dart';

extension AccountLogin on BuildContext {

  registerAccount(RegisterPayload data, Function registerSuccess, Function registerError) {
    showDialog(
      barrierDismissible: false,
      context: this,
      builder: (BuildContext context) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            back();
            if(state is RegisterSuccessState){
              registerSuccess(state.message);
            }
            if(state is RegisterFailState){
              registerError(state.error);
            }
          },
          child: WillPopScope(
            onWillPop: () async => false,
            child: showLoader(),
          ),
        );
      },
    );
    BlocProvider.of<AuthBloc>(this).add(RegisterEvent(data));
  }

  loginAccount(RegisterPayload data, Function loginCallback) {
    showDialog(
      barrierDismissible: false,
      context: this,
      builder: (BuildContext context) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            back();
            if(state is LoginSuccessState){
              replace(const ProfileScreen());
            }
            if(state is LoginFailState){
              loginCallback(state.error);
            }
          },
          child: WillPopScope(
            onWillPop: () async => false,
            child: showLoader(),
          ),
        );
      },
    );
    BlocProvider.of<AuthBloc>(this).add(LoginEvent(data));
  }
}