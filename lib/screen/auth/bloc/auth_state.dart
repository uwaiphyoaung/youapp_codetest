part of 'auth_bloc.dart';

abstract class AuthState {}

class ResetState extends AuthState{}

class AuthInitial extends AuthState {}

//AuthState
class RegisterSuccessState extends AuthState{
  String message;
  RegisterSuccessState(this.message);
}
class RegisterFailState extends AuthState{
  ApiError? error;
  RegisterFailState(this.error);
}

//Login
class LoginSuccessState extends AuthState{}
class LoginFailState extends AuthState{
  ApiError? error;
  LoginFailState(this.error);
}
