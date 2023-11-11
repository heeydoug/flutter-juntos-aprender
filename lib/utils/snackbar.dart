import 'package:flutter/material.dart';

showSnackBar(
    {required BuildContext context,
    required String texto,
    bool isErro = true}) {
  SnackBar snackBar = SnackBar(
    content: Text(texto),
    backgroundColor: (isErro) ? Colors.red : Colors.green,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    duration: const Duration(seconds: 4),
    showCloseIcon: true,
    closeIconColor: Colors.white,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
