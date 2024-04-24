import 'package:flutter/material.dart';

extension AppNavigation on BuildContext {
  void replace(T) async {
    Navigator.pushReplacement(
        this,
        MaterialPageRoute(builder: (context) => T),
    );
  }

  void next(T, {Function? callBack}) async {
    var val = await Navigator.push(
      this,
      MaterialPageRoute(
        builder: (_) => T,
      ),
    );
    if (callBack != null) {
      callBack(val);
    }
  }

  void back({String? val}) {
    Navigator.pop(this, val ?? "");
  }

}