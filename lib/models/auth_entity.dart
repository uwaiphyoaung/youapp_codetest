class RegisterPayload {

  String email;
  String username;
  String password;

  RegisterPayload(this.email, this.username, this.password);

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['username'] = username;
    data['password'] = password;
    return data;
  }

}

class RegisterResponse{

  String? message;

  RegisterResponse(this.message);

  RegisterResponse.fromMap(Map<String, dynamic> value){
    message = value['message'];
  }
}

class LoginResponse{

  String? message;
  String? access_token;

  LoginResponse(this.message,this.access_token);

  LoginResponse.fromMap(Map<String, dynamic> value){
    message = value['message'];
    access_token = value['access_token'];
  }
}

class ErrorData {
  int? statusCode;
  List<String>? message;
  String? error;

  ErrorData(this.statusCode, this.message);

  ErrorData.fromMap(Map<String, dynamic> value) {
    statusCode = value['statusCode'];
    if(value['message'] is List<dynamic>){
      message = value['message'].cast<String>();
    }else{
      message = [value['message']];
    }
    error = value['error'];
  }
}