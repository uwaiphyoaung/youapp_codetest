import 'dart:async';

import 'package:flutter/material.dart';
import 'package:youapp_code_challenge/extensions/context_extension.dart';
import 'package:youapp_code_challenge/screen/widget/background_widget.dart';
import 'package:youapp_code_challenge/screen/widget/loading_widget.dart';

import '../auth/login_screen.dart';

class SplashScreen extends StatefulWidget{

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>{

  void startTimer(){
    var duration = const Duration(seconds: 3);
    Timer.periodic(duration, (timer) {
      timer.cancel();
      context.replace(const LoginScreen());
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BgView(),
          Center(
            child: LoadingWidget(),
          )
        ],
      )
    );
  }

}