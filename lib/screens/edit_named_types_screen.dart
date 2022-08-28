import 'dart:async';

import 'package:easyt/forms/edit_named_type_form.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditNamedTypesScreen extends StatefulWidget {
  Map<String, String> namedTypes;

  EditNamedTypesScreen({Key? key, required this.namedTypes}) : super(key: key);

  @override
  State<EditNamedTypesScreen> createState() => _EditNamedTypesScreenState();
}

class _EditNamedTypesScreenState extends State<EditNamedTypesScreen> {
  final editBroadcast = StreamController.broadcast();

  @override
  Widget build(BuildContext context) {
    List<EditNamedTypeForm> items = [];
    for (MapEntry<String, String> entry in widget.namedTypes.entries) {
      items.add(EditNamedTypeForm(
        namedTypeId: entry.key,
        namedTypeCurrentName: entry.value,
        namedTypeEditStream: editBroadcast.stream,
        namedTypeDeleted: (String id) {
          setState(() {
            widget.namedTypes.remove(id);
            if (widget.namedTypes.isEmpty) {
              Navigator.pop(context);
            }
          });
        },
      ));
    }
    return ListView.separated(
        itemBuilder: (context, i) {
          if (items.length == i) {
            return ElevatedButton(
                onPressed: () {
                  editBroadcast.sink.add(null);
                  Navigator.pop(context);
                },
                child: const Text("Edit"));
          }
          return items[i];
        },
        separatorBuilder: (context, i) =>
            const Divider(thickness: 2, color: Color.fromARGB(255, 0, 0, 0)),
        itemCount: items.length + 1);
  }
}
