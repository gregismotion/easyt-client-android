import 'dart:async';

import 'package:easyt/forms/collection/edit_collection_form.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditCollectionsScreen extends StatefulWidget {
  Map<String, String> collections;

  EditCollectionsScreen({Key? key, required this.collections})
      : super(key: key);

  @override
  State<EditCollectionsScreen> createState() => _EditCollectionsScreenState();
}

class _EditCollectionsScreenState extends State<EditCollectionsScreen> {
  final editBroadcast = StreamController.broadcast();

  @override
  Widget build(BuildContext context) {
    List<EditCollectionForm> items = [];
    for (MapEntry<String, String> entry in widget.collections.entries) {
      items.add(EditCollectionForm(
        collectionId: entry.key,
        collectionCurrentName: entry.value,
        collectionEditStream: editBroadcast.stream,
        collectionDeleted: (String id) {
          setState(() {
            widget.collections.remove(id);
            if (widget.collections.isEmpty) {
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
