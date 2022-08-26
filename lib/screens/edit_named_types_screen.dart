import 'dart:async';

import 'package:easyt/forms/edit_named_type_form.dart';
import 'package:flutter/material.dart';

class EditNamedTypesScreen extends StatelessWidget {
  final Map<String, String> namedTypes;
  final editBroadcast = StreamController.broadcast();

  EditNamedTypesScreen({Key? key, required this.namedTypes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<EditNamedTypeForm> items = [];
    for (MapEntry<String, String> entry in namedTypes.entries) {
      items.add(EditNamedTypeForm(
        namedTypeId: entry.key,
        currentValue: entry.value,
        editStream: editBroadcast.stream,
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
