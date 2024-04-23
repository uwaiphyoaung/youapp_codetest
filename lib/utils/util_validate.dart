
class UtilValidate {

  static dynamic validateBasic(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required.";
    }
    return null;
  }

  static dynamic validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required.";
    } else {
      String pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = RegExp(pattern);
      if (!regExp.hasMatch(value)) {
        return "This field is required.";
      } else {
        return null;
      }
    }
  }
}