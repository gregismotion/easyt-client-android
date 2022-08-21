import 'package:auto_route/auto_route.dart';
import 'package:easyt/data/data.dart';
import 'package:easyt/misc/collection_list_view.dart';
import 'package:easyt/misc/editable_list_view.dart';
import 'package:easyt/routes/router.gr.dart';
import 'package:flutter/material.dart';

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({Key? key}) : super(key: key);

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

// TODO: only exit on deletion from edit IF it was the last item

class _CollectionsScreenState extends State<CollectionsScreen> {
  Widget actionButton = FloatingActionButton(
      onPressed: () {
        print("default...");
      },
      child: const Icon(Icons
          .add)); // FIXME: the default could change in the EditableListView, this seems sensible for now...
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CollectionListView(
            changeActionButton: (Widget newActionButton) => setState(() {
                  actionButton = newActionButton;
                })),
        floatingActionButton: actionButton);
  }
}
