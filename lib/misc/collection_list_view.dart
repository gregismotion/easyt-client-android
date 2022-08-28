import 'package:auto_route/auto_route.dart';
import 'package:easyt/controllers/selection_controller.dart';
import 'package:easyt/data/data.dart';
import 'package:easyt/data/provider.dart';
import 'package:easyt/misc/action_button_mixin.dart';
import 'package:easyt/misc/collection_tile.dart';
import 'package:easyt/misc/editable_list_view.dart';
import 'package:easyt/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CollectionListView extends StatefulWidget with ActionButtonMixin {
  CollectionListView({Key? key}) : super(key: key);

  @override
  State<CollectionListView> createState() => _CollectionListViewState();
}

class _CollectionListViewState extends State<CollectionListView> {
  Map<String, String> _referencesToMap(List<dynamic> references) {
    // FIXME: type safety...
    Map<String, String> collections = {};
    for (CollectionReference collectionReference in references) {
      collections[collectionReference.id] = collectionReference.name;
    }
    return collections;
  }

  @override
  Widget build(BuildContext context) {
    EditableListView<CollectionReference> listView = EditableListView(
      tileCreator:
          (SelectionController selectionController, dynamic reference) {
        return CollectionTile(
            collectionId: (reference as CollectionReference).id,
            selectionController:
                selectionController); // FIXME: can't provide type safety as of generics...
      },
      fetchReferencePage: (int size, String pageKey) {
        return Provider.of<CollectionProvider>(context, listen: false)
            .getCollectionReferences(size, pageKey);
      },
      referenceToKey: (dynamic reference) {
        // FIXME: type safety...
        return reference.id;
      },
      setRefreshListener: (PagingController pagingController) => {
        Provider.of<CollectionProvider>(context)
            .addListener(() => pagingController.refresh())
      },
      editReferences: (List<dynamic> references) {
        // FIXME: type safety...
        AutoRouter.of(context).push(
            EditCollectionsRoute(collections: _referencesToMap(references)));
      },
      createReference: () {
        AutoRouter.of(context).push(const CreateCollectionRoute());
      },
      changeActionButton: (bool isEditing, void Function() onPressed) =>
          widget.changeActionButton(isEditing, onPressed),
    );
    return listView;
  }
}
