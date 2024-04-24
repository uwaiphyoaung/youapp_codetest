import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:youapp_code_challenge/app/constants/app.colors.dart';
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
    BlocProvider.of<ProfileBloc>(this).add(CreateProfileEvent(data));
  }

  updateProfile(ProfileCreatePayload data, Function successState, Function failState) {
    showDialog(
      barrierDismissible: false,
      context: this,
      builder: (BuildContext context) {
        return BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            back();
            if(state is ProfileUpdateSuccessState){
              successState();
            }
            if(state is ProfileUpdateFailState){
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
    BlocProvider.of<ProfileBloc>(this).add(UpdateProfileEvent(data));
  }

  fetchProfile(Function successState, Function failState){
    showDialog(
      barrierDismissible: false,
      context: this,
      builder: (BuildContext context) {
        return BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            back();
            if(state is ProfileDataSuccessState){
              successState();
            }
            if(state is ProfileDataFailState){
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
    BlocProvider.of<ProfileBloc>(this).add(FetchProfileEvent());
  }

  Future pickProfileImage(Function successState, Function failState) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: AppColor.primaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Crop Image',
          )
        ],
      );

      successState(File(croppedFile!.path));
    } on PlatformException catch (e) {
      failState("Failed to pick image");
    }
  }
}