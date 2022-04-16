import 'package:easyt/data/data.dart';
import 'package:easyt/data/memory.dart';
import 'package:flutter/widgets.dart';

class DataProvider extends ChangeNotifier implements Data {
  final Data _data = DataMemory();

  @override
  ReferenceGroup addDataGroup(String colId, DataGroup dataGroup) {
    var result = _data.addDataGroup(colId, dataGroup);
    notifyListeners();
    return result;
  }

  @override
  CollectionReference createCollection(String name) {
    var result = _data.createCollection(name);
    notifyListeners();
    return result;
  }

  @override
  NamedType createNamedType(NamedType namedType) {
    var result = _data.createNamedType(namedType);
    notifyListeners();
    return result;
  }

  @override
  void deleteCollection(String id) {
    _data.deleteCollection(id);
    notifyListeners();
  }

  @override
  void deleteDataPoint(String colId, String groupId, String dataId) {
    _data.deleteDataPoint(colId, groupId, dataId);
    notifyListeners();
  }

  @override
  void deleteNamedType(String id) {
    _data.deleteNamedType(id);
    notifyListeners();
  }

  @override
  List<BasicType> getBasicTypes() {
    return _data.getBasicTypes();
  }

  @override
  List<CollectionReference> getCollectionReferences(int size, String lastId) {
    return _data.getCollectionReferences(size, lastId);
  }

  @override
  DataPoint getDataPoint(String colId, String groupId, String dataId) {
    return _data.getDataPoint(colId, groupId, dataId);
  }

  @override
  NamedType getNamedType(String id) {
    return _data.getNamedType(id);
  }

  @override
  List<NamedType> getNamedTypes(int size, String lastId) {
    return _data.getNamedTypes(size, lastId);
  }

  @override
  ReferenceCollection getReferenceCollection(
      String id, int size, String lastId) {
    return _data.getReferenceCollection(id, size, lastId);
  }

  @override
  void editCollection(String id, String name) {
    _data.editCollection(id, name);
    notifyListeners();
  }

  @override
  void editDataPoint(
      String colId, String groupId, String dataId, String newValue) {
    _data.editDataPoint(colId, groupId, dataId, newValue);
    notifyListeners();
  }

  @override
  void editNamedType(String id, String name) {
    _data.editNamedType(id, name);
    notifyListeners();
  }
}
