part of 'profile_bloc.dart';

abstract class ProfileEvent {}

//Create
class CreateProfileEvent extends ProfileEvent{
  ProfileCreatePayload data;
  CreateProfileEvent(this.data);
}

//Update
class UpdateProfileEvent extends ProfileEvent{
  ProfileCreatePayload data;
  UpdateProfileEvent(this.data);
}

//Fetch Data
class FetchProfileEvent extends ProfileEvent{}
