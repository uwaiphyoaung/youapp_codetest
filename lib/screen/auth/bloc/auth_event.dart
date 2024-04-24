part of 'auth_bloc.dart';

abstract class AuthEvent {}

//Login
class LoginEvent extends AuthEvent{
  RegisterPayload data;
  LoginEvent(this.data);
}

//Register
class RegisterEvent extends AuthEvent{
  RegisterPayload data;
  RegisterEvent(this.data);
}
