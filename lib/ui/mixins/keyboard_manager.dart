import 'package:flutter/material.dart';

mixin KeyboardManager {
  void hideKeyboard(BuildContext context) {
    final currectFocus = FocusScope.of(context);
    if (!currectFocus.hasPrimaryFocus) {
      currectFocus.unfocus();
    }
  }
}
