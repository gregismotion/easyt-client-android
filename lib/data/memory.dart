import 'package:easyt/data/data.dart';
import 'package:uuid/uuid.dart';

class Collection {
  final Uuid uuid = const Uuid();

  final String id;
  final String name;
  final DataGroups data;
  Collection(this.id, this.name, this.data);
  Collection.create(this.name)
      : id = const Uuid().v1(),
        data = {};

  CollectionReference toReference() {
    return CollectionReference(id, name);
  }

  ReferenceCollection toReferenceCollection(int size, String lastId) {
    ReferenceGroups referenceGroups = {};
    bool throughLast = lastId.isEmpty;
    for (MapEntry group in data.entries) {
      if (throughLast) {
        List<DataPointReference> references = [];
        for (DataPoint dataPoint in group.value) {
          references.add(dataPoint.toDataPointReference());
        }
        referenceGroups[group.key] = references;
      } else if (group.key == lastId) {
        throughLast = true;
      }
    }
    return ReferenceCollection(id, name, referenceGroups);
  }

  DataGroup getDataGroup(String id) {
    final group = data[id];
    if (group == null) {
      throw NotFound("Group ($id) not found!");
    } else {
      return group;
    }
  }

  DataPoint getDataPoint(String groupId, dataId) {
    final group = getDataGroup(groupId);
    for (DataPoint dataPoint in group) {
      if (dataPoint.id == id) {
        return dataPoint;
      }
    }
    throw NotFound("DataPoint ($id) not found!");
  }

  ReferenceGroups addDataGroup(DataGroup dataGroup) {
    String id = uuid.v1();
    DataGroup newDataGroup = [];
    for (DataPoint dataPoint in dataGroup) {
      newDataGroup.add(DataPoint(
          uuid.v1(), dataPoint.namedType, dataPoint.time, dataPoint.value));
    }
    data[id] = newDataGroup;
    ReferenceGroup referenceGroup = [];
    for (DataPoint dataPoint in newDataGroup) {
      referenceGroup.add(dataPoint.toDataPointReference());
    }
    ReferenceGroups referenceGroups = {id: referenceGroup};
    return referenceGroups;
  }

  void deleteDataPoint(String groupId, dataId) {
    final group = getDataGroup(groupId);
    for (DataPoint dataPoint in group) {
      if (dataPoint.id == id) {
        group.remove(dataPoint);
      }
    }
    throw NotFound("DataPoint ($id) not found!");
  }
}

class DataMemory implements Data {
  final List<BasicType> basicTypes = [BasicType.num, BasicType.str];
  List<NamedType> namedTypes = [];
  List<Collection> collections = [];

  @override
  List<BasicType> getBasicTypes() {
    return basicTypes;
  }

  @override
  List<NamedType> getNamedTypes() {
    return namedTypes;
  }

  @override
  NamedType getNamedType(String id) {
    for (var namedType in namedTypes) {
      if (namedType.id == id) {
        return namedType;
      }
    }
    throw NotFound("NamedType ($id) not found!");
  }

  @override
  NamedType createNamedType(NamedType namedType) {
    final idNamedType =
        NamedType(const Uuid().v1(), namedType.name, namedType.basicType);
    namedTypes.add(idNamedType);
    return idNamedType;
  }

  @override
  void deleteNamedType(String id) {
    namedTypes.remove(getNamedType(id));
  }

  @override
  List<CollectionReference> getCollectionReferences(int size, String lastId) {
    List<CollectionReference> references = [];
    bool throughLast = lastId.isEmpty;
    for (var collection in collections) {
      if (throughLast) {
        references.add(collection.toReference());
      } else if (collection.id == lastId) {
        throughLast = true;
      }
    }
    return references;
  }

  Collection _getCollection(String id) {
    for (var collection in collections) {
      if (collection.id == id) {
        return collection;
      }
    }
    throw NotFound("Collection ($id) not found!");
  }

  @override
  ReferenceCollection getReferenceCollection(
      String id, int size, String lastId) {
    return _getCollection(id).toReferenceCollection(size, lastId);
  }

  @override
  CollectionReference createCollection(String name) {
    var collection = Collection.create(name);
    collections.add(collection);
    return collection.toReference();
  }

  @override
  void deleteCollection(String id) {
    collections.remove(_getCollection(id));
  }

  @override
  DataPoint getDataPoint(String colId, String groupId, String dataId) {
    final collection = _getCollection(colId);
    return collection.getDataPoint(groupId, dataId);
  }

  @override
  ReferenceGroups addDataGroup(String colId, DataGroup dataGroup) {
    final collection = _getCollection(colId);
    return collection.addDataGroup(dataGroup);
  }

  @override
  void deleteDataPoint(String colId, groupId, dataId) {
    final collection = _getCollection(colId);
    collection.deleteDataPoint(groupId, dataId);
  }
}
