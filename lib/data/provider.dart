import 'package:easyt/data/data.dart';
import 'package:flutter/widgets.dart';

class TypeProvider extends ChangeNotifier {
  final Data _data;
  TypeProvider(this._data);

  List<BasicType> getBasicTypes() {
    return _data.getBasicTypes();
  }

  NamedType getNamedType(String id) {
    return _data.getNamedType(id);
  }

  List<NamedType> getNamedTypes(int size, String lastId) {
    return _data.getNamedTypes(size, lastId);
  }

  NamedType createNamedType(NamedType namedType) {
    var result = _data.createNamedType(namedType);
    notifyListeners();
    return result;
  }

  void editNamedType(String id, String name) {
    _data.editNamedType(id, name);
    notifyListeners();
  }

  void deleteNamedType(String id) {
    _data.deleteNamedType(id);
    notifyListeners();
  }
}

class CollectionProvider extends ChangeNotifier {
  final Data _data;
  CollectionProvider(this._data);

  List<CollectionReference> getCollectionReferences(int size, String lastId) {
    return _data.getCollectionReferences(size, lastId);
  }

  ReferenceCollection getReferenceCollection(
      String id, int size, String lastId) {
    return _data.getReferenceCollection(id, size, lastId);
  }

  CollectionReference createCollection(String name) {
    var result = _data.createCollection(name);
    notifyListeners();
    return result;
  }

  void editCollection(String id, String name) {
    _data.editCollection(id, name);
    notifyListeners();
  }

  void deleteCollection(String id) {
    _data.deleteCollection(id);
    notifyListeners();
  }
}

class DataProvider extends ChangeNotifier {
  final Data _data;
  DataProvider(this._data);

  DataPoint getDataPoint(String colId, String groupId, String dataId) {
    return _data.getDataPoint(colId, groupId, dataId);
  }

  ReferenceGroup addDataGroup(String colId, DataGroup dataGroup) {
    var result = _data.addDataGroup(colId, dataGroup);
    notifyListeners();
    return result;
  }

  void editDataGroup(String colId, String groupId, DateTime date) {
    _data.editDataGroup(colId, groupId, date);
    notifyListeners();
  }

  void deleteDataGroup(String colId, String groupId) {
    _data.deleteDataGroup(colId, groupId);
    notifyListeners();
  }

  void editDataPoint(
      String colId, String groupId, String dataId, String newValue) {
    _data.editDataPoint(colId, groupId, dataId, newValue);
    notifyListeners();
  }

  void deleteDataPoint(String colId, String groupId, String dataId) {
    _data.deleteDataPoint(colId, groupId, dataId);
    notifyListeners();
  }
}
