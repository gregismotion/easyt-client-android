import 'package:auto_route/auto_route.dart';
import 'package:easyt/controllers/selection_controller.dart';
import 'package:easyt/data/data.dart';
import 'package:easyt/data/provider.dart';
import 'package:easyt/misc/tile.dart';
import 'package:easyt/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CollectionTile extends Tile<dynamic> {
  final String collectionId;
  final SelectionController<dynamic>
      selectionController; // FIXME: would be good to provide type safety...

  CollectionTile(
      {Key? key, required this.collectionId, required this.selectionController})
      : super(key: key, internalSelectionController: selectionController);

  @override
  _CollectionTileState createState() => _CollectionTileState();
}

class _CollectionTileState
    extends TileState<CollectionReference, CollectionTile> {
  @override
  void onTap() {
    AutoRouter.of(context)
        .push(CollectionRoute(collectionId: widget.collectionId));
  }

  @override
  Widget build(BuildContext context) {
    ReferenceCollection referenceCollection =
        Provider.of<CollectionProvider>(context)
            .getReferenceCollection(widget.collectionId, 0, "");
    reference =
        CollectionReference(referenceCollection.id, referenceCollection.name);
    return super.build(context);
  }
}
