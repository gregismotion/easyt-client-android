import 'package:easyt/data/data.dart';
import 'package:easyt/data/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({Key? key}) : super(key: key);
  static const String route = "/collection/list";

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  final _collectionReferences = <CollectionReference>[];
  late ScrollController _controller;

  @override
  void initState() {
    // NOTE: debug stuff....
    for (var i = 0; i <= 1000; i++) {
      Provider.of<DataProvider>(context, listen: false)
          .createCollection("test$i");
    }
    _controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  Widget _buildCollection(CollectionReference collection) {
    return ListTile(
      title: Text(collection.name),
    );
  }

  void _scrollListener() {
    if (_controller.position.extentAfter < 500) {
      var lastId = "";
      if (_collectionReferences.isNotEmpty) {
        lastId = _collectionReferences.last.id;
      }
      _collectionReferences.addAll(
          Provider.of<DataProvider>(context, listen: false)
              .getCollectionReferences(10, lastId));
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

  @override
  Widget build(BuildContext context) {
    _collectionReferences.addAll(
        Provider.of<DataProvider>(context).getCollectionReferences(10, ""));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Collections"),
      ),
      body: _buildCollections(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
