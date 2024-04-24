import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_code_challenge/app/theme/app_theme.dart';
import 'package:youapp_code_challenge/screen/auth/bloc/auth_bloc.dart';
import 'package:youapp_code_challenge/screen/profile/bloc/profile_bloc.dart';
import 'package:youapp_code_challenge/screen/splash/splash_screen.dart';

class YouApp extends StatefulWidget{
  const YouApp({super.key});

  @override
  ChallengeAppState createState ()=> ChallengeAppState();
}

class ChallengeAppState extends State<YouApp>{

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (BuildContext context) => ProfileBloc(),
        )
      ],
      child: MaterialApp(
        title: 'YouApp Code Challenge',
        debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
        home: SplashScreen(),
      ),
    );
  }

}