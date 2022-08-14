import 'package:auto_route/auto_route.dart';
import 'package:easyt/controllers/selection_controller.dart';
import 'package:easyt/data/data.dart';
import 'package:easyt/data/provider.dart';
import 'package:easyt/misc/collection_list_view.dart';
import 'package:easyt/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({Key? key}) : super(key: key);

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  final _pagingController =
      PagingController<String, CollectionReference>(firstPageKey: "");
  final _selectionController = SelectionController<CollectionReference>();

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) => _fetchPage(pageKey));
    _selectionController.addListener(() {});
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _selectionController.dispose();
    super.dispose();
  }

  void _createCollection() {
    AutoRouter.of(context).push(const CreateCollectionRoute());
  }

  void _editCollections() {
    Map<String, String> collections = {};
    for (CollectionReference collectionReference
        in _selectionController.selected) {
      collections[collectionReference.id] = collectionReference.name;
    }
    _selectionController.isSelectionMode = false;
    AutoRouter.of(context).push(EditCollectionsRoute(collections: collections));
  }

  void _fetchPage(String pageKey) {
    const int size = 10;
    try {
      final List<CollectionReference> collectionReferencePage =
          Provider.of<CollectionProvider>(context, listen: false)
              .getCollectionReferences(size, pageKey);
      if (collectionReferencePage.length < size) {
        _pagingController.appendLastPage(collectionReferencePage);
      } else {
        _pagingController.appendPage(
            collectionReferencePage, collectionReferencePage.last.id);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  void _prepareListener() {
    Provider.of<CollectionProvider>(context)
        .addListener(() => _pagingController.refresh());
  }

  Widget _getActionButton() {
    if (_selectionController.isSelectionMode) {
      return FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: _editCollections,
      );
    } else {
      return FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _createCollection,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _prepareListener();
    return Scaffold(
        body: RefreshIndicator(
            onRefresh: () => Future.sync(() => _pagingController.refresh()),
            child: CollectionListView(
                pagingController: _pagingController,
                selectionController: _selectionController)),
        floatingActionButton: _getActionButton());
  }
}
