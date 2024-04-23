part of 'auth_bloc.dart';

abstract class AuthEvent {}

//Login
class LoginEvent extends AuthEvent{
  BuildContext context;
  RegisterPayload data;
  LoginEvent(this.context,this.data);
}

//Register
class RegisterEvent extends AuthEvent{
  BuildContext context;
  RegisterPayload data;
  RegisterEvent(this.context,this.data);
}
