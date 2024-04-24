import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:youapp_code_challenge/app/api/api_response.dart';
import 'package:youapp_code_challenge/models/auth_entity.dart';
import 'package:youapp_code_challenge/screen/widget/snackbar_util.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  BaseScreenState createState() => BaseScreenState();
}

class BaseScreenState<T extends BaseScreen> extends State<T> {
  late ScaffoldMessengerState snackbar;

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    snackbar = ScaffoldMessenger.of(context);
  }

  @override
  void dispose() {
    snackbar.hideCurrentSnackBar();
    super.dispose();
  }

  void showSuccessMessage(String message){
    snackbar.showSnackBar(buildSnackBar(message, true));
  }

  void showError(String message){
    snackbar.showSnackBar(buildSnackBar(message, false));
  }

  void showErrorMessage(ApiError error){
    switch (error.code) {
      case -1:
      case -2:
        {
          snackbar.showSnackBar(buildSnackBar(error.data, false));
        }
        break;
      case 401:
        {
          snackbar.showSnackBar(buildSnackBar("No token provided", false));
        }
        break;
      default:
        {
          var errorData = ErrorData.fromMap(json.decode(error.data));
          if(errorData.message != null && errorData.message?.isNotEmpty == true){
            snackbar.showSnackBar(buildSnackBar(errorData.message!.first, false));
          }else{
            snackbar.showSnackBar(buildSnackBar("Something went wrong", false));
          }
        }
        break;
    }
  }

}