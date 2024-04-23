
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

extension AppDialog on BuildContext {

  AlertDialog showLoader() {
    return AlertDialog(
      elevation: 3,
      insetPadding:
      EdgeInsets.symmetric(horizontal: MediaQuery.of(this).size.width / 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SpinKitFadingCircle(
            size: 40.0,
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(10)),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Text("Loading"),
        ],
      ),
    );
  }
}