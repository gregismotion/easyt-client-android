import 'package:easyt/data/data.dart';
import 'package:easyt/misc/collection_tile.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CollectionListView extends StatelessWidget {
  final PagingController<String, CollectionReference> controller;
  const CollectionListView({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PagedListView<String, CollectionReference>.separated(
      pagingController: controller,
      padding: const EdgeInsets.all(16),
      builderDelegate: // TODO: error indicators
          PagedChildBuilderDelegate(itemBuilder: (context, collectionReference, i) {
        return CollectionTile(collectionId: collectionReference.id);
      }),
      separatorBuilder: (context, i) => const Divider(
        thickness: 2,
        color: Color.fromARGB(255, 0, 0, 0),
      ), // TODO: theme
    );
  }
}
