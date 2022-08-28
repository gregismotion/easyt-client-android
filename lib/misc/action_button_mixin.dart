import 'package:flutter/material.dart';

mixin ActionButtonMixin on Widget {
  // ignore: prefer_function_declarations_over_variables
  void Function(bool, void Function()) changeActionButton =
      (bool isEditing, void Function() onPressed) {};
}
