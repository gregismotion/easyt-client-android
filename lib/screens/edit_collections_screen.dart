import 'dart:async';

import 'package:easyt/forms/edit_collection_form.dart';
import 'package:flutter/material.dart';

class EditCollectionsScreen extends StatelessWidget {
  final Map<String, String> collections;
  final editBroadcast = StreamController.broadcast();

  EditCollectionsScreen({Key? key, required this.collections})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<EditCollectionForm> items = [];
    for (MapEntry<String, String> entry in collections.entries) {
      items.add(EditCollectionForm(
        collectionId: entry.key,
        currentName: entry.value,
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
