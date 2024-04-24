part of 'profile_bloc.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ResetState extends ProfileState{}

//create
class ProfileCreateSuccessState extends ProfileState{}
class ProfileCreateFailState extends ProfileState{
  ApiError? error;
  ProfileCreateFailState(this.error);
}

//update
class ProfileUpdateSuccessState extends ProfileState{}
class ProfileUpdateFailState extends ProfileState{
  ApiError? error;
  ProfileUpdateFailState(this.error);
}

//profile data
class ProfileDataSuccessState extends ProfileState{

}
class ProfileDataFailState extends ProfileState{
  ApiError? error;
  ProfileDataFailState(this.error);
}