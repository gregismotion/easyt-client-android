import 'dart:io';

import 'package:easyt/data/data.dart';
import 'package:easyt/data/memory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: const MaterialApp(title: "EasyT", home: CollectionsScreen()),
      providers: [ChangeNotifierProvider.value(value: DataProvider())],
    );
  }
}

class DataProvider extends ChangeNotifier implements Data {
  final Data data = DataMemory();

  @override
  ReferenceGroups addDataGroup(String colId, DataGroup dataGroup) {
    var result = data.addDataGroup(colId, dataGroup);
    notifyListeners();
    return result;
  }

  @override
  CollectionReference createCollection(String name) {
    var result = data.createCollection(name);
    //notifyListeners();
    // FIXME: while debugging we can't do this 'cos we create collections in the build phase...
    return result;
  }

  @override
  NamedType createNamedType(NamedType namedType) {
    var result = data.createNamedType(namedType);
    notifyListeners();
    return result;
  }

  @override
  void deleteCollection(String id) {
    data.deleteCollection(id);
    notifyListeners();
  }

  @override
  void deleteDataPoint(String colId, groupId, dataId) {
    data.deleteDataPoint(colId, groupId, dataId);
    notifyListeners();
  }

  @override
  void deleteNamedType(String id) {
    data.deleteNamedType(id);
    notifyListeners();
  }

  @override
  List<BasicType> getBasicTypes() {
    return data.getBasicTypes();
  }

  @override
  List<CollectionReference> getCollectionReferences(int size, String lastId) {
    return data.getCollectionReferences(size, lastId);
  }

  @override
  DataPoint getDataPoint(String colId, String groupId, String dataId) {
    return data.getDataPoint(colId, groupId, dataId);
  }

  @override
  NamedType getNamedType(String id) {
    return data.getNamedType(id);
  }

  @override
  List<NamedType> getNamedTypes() {
    return data.getNamedTypes();
  }

  @override
  ReferenceCollection getReferenceCollection(
      String id, int size, String lastId) {
    return data.getReferenceCollection(id, size, lastId);
  }
}

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
    );
  }
}
