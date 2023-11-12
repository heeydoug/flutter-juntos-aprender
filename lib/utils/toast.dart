import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';

void AlertMessage(BuildContext context, String msg) {
  FToast.toast(
    context,
    msg: msg,
    color: const Color.fromARGB(255, 190, 180, 89),
    duration: 5000,
    msgStyle: TextStyle(
      color: const Color.fromARGB(255, 0, 0, 0),
      fontSize: 16.0,
    ),
  );
}

void WarningMessage(BuildContext context, String msg) {
  FToast.toast(
    context,
    msg: msg,
    color: Colors.red,
    duration: 5000,
    msgStyle: TextStyle(
      color: Colors.white,
      fontSize: 16.0,
    ),
  );
}
