import 'package:easyt/misc/named_type_list_view.dart';
import 'package:flutter/material.dart';

class NamedTypesScreen extends StatefulWidget {
  const NamedTypesScreen({Key? key}) : super(key: key);

  @override
  State<NamedTypesScreen> createState() => _NamedTypesScreenState();
}

class _NamedTypesScreenState extends State<NamedTypesScreen> {
  Widget actionButton = FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons
          .add)); // FIXME: the default could change in the EditableListView, this seems sensible for now...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NamedTypeListView(
            changeActionButton: (Widget newActionButton) => setState(() {
                  actionButton = newActionButton;
                })),
        floatingActionButton: actionButton);
  }
}
