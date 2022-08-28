import 'package:easyt/misc/collection_list_view.dart';
import 'package:easyt/misc/dynamic_action_button.dart';
import 'package:flutter/material.dart';

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({Key? key}) : super(key: key);

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  bool isEditing = false;
  // ignore: prefer_function_declarations_over_variables
  void Function() actionButtonOnPressed = () {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CollectionListView(
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
