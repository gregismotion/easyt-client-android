import 'package:easyt/data/data.dart';
import 'package:easyt/data/memory.dart';
import 'package:flutter/widgets.dart';

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
    notifyListeners();
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
