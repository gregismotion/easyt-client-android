import 'package:auto_route/auto_route.dart';
import 'package:easyt/data/data.dart';
import 'package:easyt/data/provider.dart';
import 'package:easyt/misc/collection_list_view.dart';
import 'package:easyt/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

// TODO: switch to infinite_scroll_pagination

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({Key? key}) : super(key: key);

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  final _controller =
      PagingController<String, CollectionReference>(firstPageKey: "");

  @override
  void initState() {
    super.initState();
    _controller.addPageRequestListener((pageKey) => _fetchPage(pageKey));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _createCollection() {
    AutoRouter.of(context).push(const CreateCollectionRoute());
  }

  void _fetchPage(String pageKey) {
    const int size = 10;
    try {
      final List<CollectionReference> collectionReferencePage =
          Provider.of<DataProvider>(context, listen: false)
              .getCollectionReferences(size, pageKey);
      if (collectionReferencePage.length < size) {
        _controller.appendLastPage(collectionReferencePage);
      } else {
        _controller.appendPage(
            collectionReferencePage, collectionReferencePage.last.id);
      }
    } catch (error) {
      _controller.error = error;
    }
  }

  void _prepareListener() {
    Provider.of<DataProvider>(context).addListener(() => _controller.refresh());
  }

  @override
  Widget build(BuildContext context) {
    _prepareListener();
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: () => Future.sync(() => _controller.refresh()),
          child: CollectionListView(controller: _controller)),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _createCollection,
      ),
    );
  }
}
