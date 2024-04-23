import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_code_challenge/extensions/context_extension.dart';
import 'package:youapp_code_challenge/extensions/dialog.extension.dart';
import 'package:youapp_code_challenge/models/profile_entity.dart';
import 'package:youapp_code_challenge/screen/profile/bloc/profile_bloc.dart';

extension UserProfile on BuildContext {

  Future<void>  selectDate(
      DateTime? selectedDate,
      Function updatedDate,
      ) async {
    final DateTime? picked = await showDatePicker(
        context: this,
        initialDate: selectedDate??DateTime(2006),
        firstDate: DateTime(1900),
        lastDate: DateTime(2006)
    );
    if (picked != null && picked != selectedDate) {
      updatedDate(picked);
    }
  }

  createProfile(ProfileCreatePayload data, Function successState, Function failState) {
    showDialog(
      barrierDismissible: false,
      context: this,
      builder: (BuildContext context) {
        return BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            back();
            if(state is ProfileCreateSuccessState){
              successState();
            }
            if(state is ProfileCreateFailState){
              failState(state.error);
            }
          },
          child: WillPopScope(
            onWillPop: () async => false,
            child: showLoader(),
          ),
        );
      },
    );
    BlocProvider.of<ProfileBloc>(this).add(CreateProfileEvent(this,data));
  }

  updateProfile(ProfileCreatePayload data) {
    showDialog(
      barrierDismissible: false,
      context: this,
      builder: (BuildContext context) {
        return BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            back();
            if(state is ProfileUpdateSuccessState){

            }
          },
          child: WillPopScope(
            onWillPop: () async => false,
            child: showLoader(),
          ),
        );
      },
    );
    BlocProvider.of<ProfileBloc>(this).add(UpdateProfileEvent(this,data));
  }
}