import 'package:youapp_code_challenge/app/constants/app.constant.dart';

class ApiEndPoint {

  static String BASE_URL = AppConstant.host;

  static String login() => "$BASE_URL/api/login";

  static String register() => "$BASE_URL/api/register";

  static String createProfile() => "$BASE_URL/api/createProfile";

  static String getProfile() => "$BASE_URL/api/getProfile";

  static String updateProfile() => "$BASE_URL/api/updateProfile";

}
