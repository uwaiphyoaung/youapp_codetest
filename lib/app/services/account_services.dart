import 'package:localstore/localstore.dart';
import 'package:youapp_code_challenge/app/api/api_response.dart';
import 'package:youapp_code_challenge/app/api/app_api.dart';
import 'package:youapp_code_challenge/app/api/app_endpoints.dart';
import 'package:youapp_code_challenge/models/auth_entity.dart';
import 'package:youapp_code_challenge/models/profile_entity.dart';

class AccountService {
  API api = API();

  Future<ApiResponse> register(RegisterPayload payload) async =>
      api.postBodyWithoutAuth(ApiEndPoint.register(), payload.toJson());

  Future<ApiResponse> login(RegisterPayload payload) async =>
      api.postBodyWithoutAuth(ApiEndPoint.login(), payload.toJson());

  Future<ApiResponse> create(ProfileCreatePayload payload) async =>
      api.postBody(ApiEndPoint.createProfile(), payload.toJson());

  Future<ApiResponse> update(ProfileCreatePayload payload) async =>
      api.putBody(ApiEndPoint.updateProfile(), payload.toJson());

  Future<ApiResponse> getProfile() async =>
      api.get(ApiEndPoint.getProfile());

  Future<bool> saveUserData(ProfileCreatePayload data) async{
    Localstore.instance
        .collection("profile")
        .doc("profile")
        .set(data.toJson());
    return true;
  }


  Future<ProfileCreatePayload?> loadUserData() async{
    var result = await Localstore.instance
        .collection("profile")
        .doc("profile")
        .get();

    if (result != null) {
      return ProfileCreatePayload.fromMap(result);
    }
    return null;
  }
}