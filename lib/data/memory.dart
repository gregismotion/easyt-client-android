import 'package:easyt/data/data.dart';
import 'package:uuid/uuid.dart';

class Collection {
  final Uuid uuid = const Uuid();

  final String id;
  String name;
  final List<DataGroup> dataGroups;
  Collection(this.id, this.name, this.dataGroups);
  Collection.create(this.name)
      : id = const Uuid().v1(),
        dataGroups = [];

  CollectionReference toReference() {
    return CollectionReference(id, name);
  }

  ReferenceCollection toReferenceCollection(int size, String lastId) {
    List<ReferenceGroup> referenceGroups = [];
    bool throughLast = lastId.isEmpty;
    for (DataGroup group in dataGroups) {
      if (throughLast) {
        referenceGroups.add(group.toReferenceGroup());
      } else if (group.id == lastId) {
        throughLast = true;
      }
    }
    return ReferenceCollection(id, name, referenceGroups);
  }

  DataGroup getDataGroup(String id) {
    for (DataGroup dataGroup in dataGroups) {
      if (dataGroup.id == id) {
        return dataGroup;
      }
    }
    throw NotFound("DataGroup ($id) not found!");
  }

  DataPoint getDataPoint(String groupId, String dataId) {
    final group = getDataGroup(groupId);
    for (DataPoint dataPoint in group.dataPoints) {
      if (dataPoint.id == dataId) {
        return dataPoint;
      }
    }
    throw NotFound("DataPoint ($dataId) not found!");
  }

  ReferenceGroup addDataGroup(DataGroup dataGroup) {
    String id = uuid.v1();
    DataGroup newGroup = DataGroup(id, dataGroup.date, []);
    for (DataPoint dataPoint in dataGroup.dataPoints) {
      newGroup.dataPoints
          .add(DataPoint(uuid.v1(), dataPoint.namedType, dataPoint.value));
    }
    dataGroups.add(newGroup);
    return newGroup.toReferenceGroup();
  }

  void deleteDataPoint(String groupId, String dataId) =>
      getDataGroup(groupId).dataPoints.remove(getDataPoint(groupId, dataId));
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
  List<NamedType> getNamedTypes(int size, String lastId) {
    List<NamedType> paginatedNamedTypes = [];
    bool throughLast = lastId.isEmpty;
    for (var namedType in namedTypes) {
      if (throughLast) {
        paginatedNamedTypes.add(namedType);
      } else if (namedType.id == lastId) {
        throughLast = true;
      }
    }
    return paginatedNamedTypes;
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
  void editNamedType(String id, name) {
    getNamedType(id).name = name;
  }

  @override
  void deleteNamedType(String id) {
    // NOTE: maybe we should only let deletion after it's not used, for data safety...
    NamedType namedType = getNamedType(id);
    for (Collection collection in collections) {
      Map<DataGroup, List<DataPoint>> targets = {};
      for (DataGroup dataGroup in collection.dataGroups) {
        if (targets[dataGroup] == null) {
          targets[dataGroup] = [];
        }
        for (DataPoint dataPoint in dataGroup.dataPoints) {
          if (dataPoint.namedType == namedType) {
            targets[dataGroup]?.add(dataPoint);
          }
        }
      }
      for (MapEntry<DataGroup, List<DataPoint>> entry in targets.entries) {
        for (DataPoint dataPoint in entry.value) {
          entry.key.dataPoints.remove(dataPoint);
        }
      }
    }
    namedTypes.remove(namedType);
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
  void editCollection(String id, name) {
    _getCollection(id).name = name;
  }

  @override
  void deleteCollection(String id) {
    collections.remove(_getCollection(id));
  }

  @override
  DataPoint getDataPoint(String colId, groupId, dataId) {
    final collection = _getCollection(colId);
    return collection.getDataPoint(groupId, dataId);
  }

  @override
  ReferenceGroup addDataGroup(String colId, DataGroup dataGroup) {
    final collection = _getCollection(colId);
    return collection.addDataGroup(dataGroup);
  }

  @override
  void deleteDataPoint(String colId, String groupId, String dataId) {
    final collection = _getCollection(colId);
    collection.deleteDataPoint(groupId, dataId);
  }

  @override
  void editDataPoint(
      String colId, String groupId, String dataId, String newValue) {
    getDataPoint(colId, groupId, dataId).value = newValue;
  }
}
