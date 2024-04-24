extension EtString on String?{

  String orEmpty() => this??"";

  String orZeroString() => this??"0";

  String getProfileName() {
    var temp = this??"";
    if(temp.contains('@')){
      var username = temp.split("@").first;
      return username.isNotEmpty == true? "@$username":"";
    }else{
      return temp;
    }
  }
}

extension EtInteger on int?{

  int orZero() => this??0;
}