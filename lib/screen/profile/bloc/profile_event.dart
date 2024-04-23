part of 'profile_bloc.dart';

abstract class ProfileEvent {}

//Create
class CreateProfileEvent extends ProfileEvent{
  BuildContext context;
  ProfileCreatePayload data;
  CreateProfileEvent(this.context,this.data);
}

//Update
class UpdateProfileEvent extends ProfileEvent{
  BuildContext context;
  ProfileCreatePayload data;
  UpdateProfileEvent(this.context,this.data);
}
