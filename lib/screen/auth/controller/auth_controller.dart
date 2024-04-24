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
    validUserName();
  }

  final email = ''.obs;
  changeEmail(String? data) {
    email(data);
    formValidate();
    validEmail();
  }

  final password = ''.obs;
  changePassword(String? data) {
    password(data);
    formValidate();
    validPwd();
  }

  final confirmPassword = ''.obs;
  changeConfirmPassword(String? data) {
    confirmPassword(data);
    formValidate();
    matchPwd();
  }

  final fromValid = false.obs;
  formValidate(){
    var state =
        checkEmail(email.value) &&
        username.value.length>= 8 &&
        checkPwd(password.value) &&
        checkPwd(confirmPassword.value) &&
        password.value == confirmPassword.value;
    fromValid(state);
  }

  clearRegisterForm(){
    changeEmail(null);
    changeUserName(null);
    changePassword(null);
    changeConfirmPassword(null);
    emailState(true);
    usernameState(true);
    pwdState(true);
    pwdMatchState(true);
  }

  bool checkPwd(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    return RegExp(pattern).hasMatch(value);
  }

  bool checkEmail(String value){
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    return RegExp(pattern).hasMatch(value);
  }

  final emailState = true.obs;
  validEmail(){
    emailState.value = email.value.length > 7 ? checkEmail(email.value) : true;
  }

  final usernameState = true.obs;
  validUserName(){
    usernameState.value = username.value.isEmpty ? true : username.value.length >= 8;
  }

  final pwdState = true.obs;
  validPwd(){
    if(password.value.isNotEmpty){
      if(password.value.length >= 8){
        pwdState.value = checkPwd(password.value);
      }else{
        pwdState.value = true;
      }
    }else{
      pwdState.value = true;
    }
  }

  final pwdMatchState = true.obs;
  matchPwd(){
    if(confirmPassword.value.isNotEmpty){
      if(confirmPassword.value.length >= 8){
        pwdMatchState.value =  checkPwd(password.value) &&
            confirmPassword.value.length >= 8 &&
            password.value == confirmPassword.value;
      }else{
        pwdMatchState.value = true;
      }

    }else{
      pwdMatchState.value =  true;
    }
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