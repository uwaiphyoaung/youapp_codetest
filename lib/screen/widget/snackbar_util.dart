import 'package:flutter/material.dart';

SnackBar buildSnackBar(String text, bool state, {Function? action}) {
  return SnackBar(
    margin: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
    padding:
    const EdgeInsets.only(left: 15.0, right: 15.0, top: 10, bottom: 10),
    behavior: SnackBarBehavior.floating,
    backgroundColor: state ? Colors.green : Colors.redAccent,
    //backgroundColor: Colors.black, //best to handle for many states (success-green, fail-red, warning-yellow, default-black)
    content: Row(
      children: [
        Icon(
          state ? Icons.check_circle : Icons.error,
          color: Colors.white,
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(child: Text(text)),
        Visibility(
          visible: action != null,
          child: TextButton(
              onPressed: () {
                action!();
                action = null;
              },
              child: const Text("View")),
        )
      ],
    ),
  );
}