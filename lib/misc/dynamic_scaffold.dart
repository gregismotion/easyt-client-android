import 'package:easyt/misc/action_button_mixin.dart';
import 'package:easyt/misc/dynamic_action_button.dart';
import 'package:flutter/material.dart';

class DynamicScaffold extends StatefulWidget {
  final ActionButtonMixin body;
  const DynamicScaffold({Key? key, required this.body}) : super(key: key);

  @override
  State<DynamicScaffold> createState() => _DynamicScaffoldState();
}

class _DynamicScaffoldState extends State<DynamicScaffold> {
  bool isEditing = false;
  // ignore: prefer_function_declarations_over_variables
  void Function() actionButtonOnPressed = () {};

  @override
  Widget build(BuildContext context) {
    widget.body.changeActionButton =
        (bool isEditingNew, void Function() onPressedNew) => setState(() {
              isEditing = isEditingNew;
              actionButtonOnPressed = onPressedNew;
            });
    return Scaffold(
        body: widget.body,
        floatingActionButton: DynamicActionButton(
            isEditing: isEditing, onPressed: actionButtonOnPressed));
  }
}
