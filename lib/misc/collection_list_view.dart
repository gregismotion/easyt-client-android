import 'package:easyt/controllers/selection_controller.dart';
import 'package:easyt/data/data.dart';
import 'package:easyt/misc/collection_tile.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CollectionListView extends StatefulWidget {
  final PagingController<String, CollectionReference> pagingController;
  final SelectionController<CollectionReference> selectionController;

  const CollectionListView(
      {Key? key,
      required this.pagingController,
      required this.selectionController})
      : super(key: key);

  @override
  State<CollectionListView> createState() => _CollectionListViewState();
}

class _CollectionListViewState extends State<CollectionListView> {
  @override
  Widget build(BuildContext context) {
    return PagedListView<String, CollectionReference>.separated(
      pagingController: widget.pagingController,
      padding: const EdgeInsets.all(16),
      builderDelegate: // TODO: error indicators
          PagedChildBuilderDelegate(
              itemBuilder: (context, collectionReference, i) {
        return CollectionTile(
            collectionId: collectionReference.id,
            selectionController: widget.selectionController);
      }),
      separatorBuilder: (context, i) => const Divider(
        thickness: 2,
        color: Color.fromARGB(255, 0, 0, 0),
      ), // TODO: theme
    );
  }
}
