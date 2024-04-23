import 'package:flutter/material.dart';

extension AppNavigation on BuildContext {
  void replace(T) async {
    Navigator.pushAndRemoveUntil(
        this,
        MaterialPageRoute(builder: (context) => T, maintainState: true),
            (Route<dynamic> route) => false
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