import 'package:flutter/material.dart';

class SnackBarHelper {
  static void showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(text),
      duration: Duration(milliseconds: 1000),
    ));
  }
}
