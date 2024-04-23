extension EtString on String?{

  String orEmpty() => this??"";

  String orZeroString() => this??"0";

}

extension EtInteger on int?{

  int orZero() => this??0;
}