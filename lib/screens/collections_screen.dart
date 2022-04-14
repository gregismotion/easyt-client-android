import 'package:auto_route/auto_route.dart';
import 'package:easyt/data/data.dart';
import 'package:easyt/data/provider.dart';
import 'package:easyt/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({Key? key}) : super(key: key);

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  final _collectionReferences = <CollectionReference>[];
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildCollection(CollectionReference collection) {
    return ListTile(
      title: Text(collection.name),
    );
  }

  void _scrollListener() {
    if (_controller.position.extentAfter < 500) {
      _collectionReferences.addAll(
          Provider.of<DataProvider>(context, listen: false)
              .getCollectionReferences(10, _getLastId()));
    }
  }

  Widget _buildCollections() {
    return ListView.builder(
      controller: _controller,
      padding: const EdgeInsets.all(16),
      itemCount: _collectionReferences.length * 2, // NOTE: cos divider...
      itemBuilder: (context, i) {
        if (i.isOdd) {
          return const Divider();
        }

        final index = i ~/ 2;
        return _buildCollection(_collectionReferences[index]);
      },
    );
  }

  void _createCollection() {
    AutoRouter.of(context).push(const CreateCollectionRoute());
  }

  String _getLastId() {
    if (_collectionReferences.isNotEmpty) {
      return _collectionReferences.last.id;
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    _collectionReferences.addAll(Provider.of<DataProvider>(context)
        .getCollectionReferences(10, _getLastId()));
    return Scaffold(
      body: _buildCollections(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _createCollection,
      ),
    );
  }
}
