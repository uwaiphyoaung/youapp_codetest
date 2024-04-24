import 'package:get/get.dart';

class AuthController extends GetxController{

  //Setup account registration
  final newPwdVisible = false.obs;
  changeNewVisible() {
    newPwdVisible(!newPwdVisible.value);
  }

  final confirmPwdVisible = false.obs;
  changeConfirmVisible() {
    confirmPwdVisible(!confirmPwdVisible.value);
  }

  final username = ''.obs;
  changeUserName(String? data) {
    username(data);
    formValidate();
  }

  final email = ''.obs;
  changeEmail(String? data) {
    email(data);
    formValidate();
  }

  final password = ''.obs;
  changePassword(String? data) {
    password(data);
    formValidate();
  }

  final confirmPassword = ''.obs;
  changeConfirmPassword(String? data) {
    confirmPassword(data);
    formValidate();
  }

  final fromValid = false.obs;
  formValidate(){
    var state =
        email.value.isNotEmpty &&
        username.value.length>8 &&
        checkPwd(password.value) &&
        checkPwd(confirmPassword.value) &&
        password.value == confirmPassword.value;
    fromValid(state);
  }

  bool checkPwd(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    return RegExp(pattern).hasMatch(value);
  }


  // Login
  final visiblePwd = false.obs;
  changeVisible() {
    visiblePwd(!visiblePwd.value);
  }

  final loginEmail = ''.obs;
  changeLoginEmail(String? data) {
    loginEmail(data);
    loginFormValidate();
  }

  final loginPassword = ''.obs;
  changeLoginPassword(String? data) {
    loginPassword(data);
    loginFormValidate();
  }

  final loginForm = false.obs;
  loginFormValidate(){
    var state =
        loginEmail.value.isNotEmpty &&
            loginPassword.value.isNotEmpty;
    loginForm(state);
  }
}