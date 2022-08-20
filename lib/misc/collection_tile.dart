import 'package:auto_route/auto_route.dart';
import 'package:easyt/controllers/selection_controller.dart';
import 'package:easyt/data/data.dart';
import 'package:easyt/data/provider.dart';
import 'package:easyt/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionTile extends StatefulWidget {
  final String collectionId;
  final SelectionController<CollectionReference> selectionController;

  const CollectionTile(
      {Key? key, required this.collectionId, required this.selectionController})
      : super(key: key);

  @override
  State<CollectionTile> createState() => _CollectionTileState();
}

class _CollectionTileState extends State<CollectionTile> {
  bool isSelected = false;
  late CollectionReference collectionReference;

  void _switchSelection() {
    setState(() {
      isSelected = !isSelected;
      widget.selectionController
          .selectionChanged(collectionReference, isSelected);
    });
  }

  @override
  void dispose() {
    widget.selectionController.removeListener(() {});
    super.dispose();
  }

  @override
  void initState() {
    widget.selectionController.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ReferenceCollection referenceCollection =
        Provider.of<CollectionProvider>(context)
            .getReferenceCollection(widget.collectionId, 0, "");
    collectionReference =
        CollectionReference(referenceCollection.id, referenceCollection.name);
    /*if (!widget.selectionController.isSelectionMode && isSelected == true) {
      setState(() {
        isSelected = false;
      });
    }*/
    return ListTile(
      selected: isSelected,
      title: Text(collectionReference.name),
      onTap: () {
        if (widget.selectionController.isSelectionMode) {
          _switchSelection();
        } else {
          AutoRouter.of(context)
              .push(CollectionRoute(collectionId: widget.collectionId));
        }
      },
      onLongPress: () {
        _switchSelection();
      },
    );
  }
}
