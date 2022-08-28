import 'package:easyt/misc/dynamic_action_button.dart';
import 'package:easyt/misc/named_type_list_view.dart';
import 'package:flutter/material.dart';

class NamedTypesScreen extends StatefulWidget {
  const NamedTypesScreen({Key? key}) : super(key: key);

  @override
  State<NamedTypesScreen> createState() => _NamedTypesScreenState();
}

class _NamedTypesScreenState extends State<NamedTypesScreen> {
  bool isEditing = false;
  // ignore: prefer_function_declarations_over_variables
  void Function() actionButtonOnPressed = () {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NamedTypeListView(
            changeActionButton:
                (bool isEditingNew, void Function() onPressedNew) =>
                    setState(() {
                      isEditing = isEditingNew;
                      actionButtonOnPressed = onPressedNew;
                    })),
        floatingActionButton: DynamicActionButton(
            isEditing: isEditing, onPressed: actionButtonOnPressed));
  }
}
