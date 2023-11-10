import 'package:flutter/material.dart';
import 'package:flutter_juntos_aprender/utils/colors.dart';

InputDecoration getLoginInputDecoration(String label) {
  return InputDecoration(
    hintText: label,
    fillColor: Colors.white,
    filled: true,
    contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(64)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(64),
      borderSide: const BorderSide(color: MyColors.azulTopGradiente, width: 4),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(64),
      borderSide: const BorderSide(color: Colors.red, width: 2),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(64),
      borderSide: const BorderSide(color: Colors.red, width: 4),
    ),
  );
}
