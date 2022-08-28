// TODO: create multiple backends

class NotFound implements Exception {
  final String msg;
  const NotFound(this.msg);
  @override
  String toString() => 'NotFound: $msg';
}

abstract class Data {
  // types
  // TODO: date
  // TODO: tags
  // TODO: icon (basic, custom)
  // TODO: more basic types
  List<BasicType> getBasicTypes();
  List<NamedType> getNamedTypes(int size, String lastId);
  NamedType getNamedType(String id);
  NamedType createNamedType(NamedType namedType);
  void editNamedType(String id, String name);
  void deleteNamedType(String id);

  //collections
  // TODO: date
  // TODO: tags
  // TODO: icon (basic, custom)
  List<CollectionReference> getCollectionReferences(int size, String lastId);
  ReferenceCollection getReferenceCollection(
      String id, int size, String lastId);
  CollectionReference createCollection(String name);
  void editCollection(String id, String name);
  void deleteCollection(String id);

  //data
  DataPoint getDataPoint(String colId, String groupId, String dataId);
  ReferenceGroup addDataGroup(String colId, DataGroup dataGroup);
  void editDataGroup(String colId, String groupId, DateTime date);
  void deleteDataGroup(String colId, String groupId);
  void editDataPoint(
      String colId, String groupId, String dataId, String newValue);
  void deleteDataPoint(String colId, String groupId, String dataId);
}

// types
enum BasicType { num, str }
Map<BasicType, String> basicTypeNames = {
  BasicType.num: "Number",
  BasicType.str: "Text"
};
String basicTypeToName(BasicType basicType) =>
    basicTypeNames[basicType] ?? "Unknown";
BasicType nameToBasicType(String name) {
  for (var entry in basicTypeNames.entries) {
    if (entry.value == name) {
      return entry.key;
    }
  }
  throw NotFound("Couldn't find basic type named $name");
}

class NamedType {
  final String id;
  String name;
  final BasicType basicType;

  NamedType(this.id, this.name, this.basicType);
  NamedType.local(this.name, this.basicType) : id = "local";
  NamedType.blank() : id = "local", name = "", basicType = BasicType.num;

  @override
  String toString() {
    return "$name (${basicTypeToName(basicType)})"; // TODO: create named type details page and remove basic type from here
  }
}

// collections
class ReferenceCollection {
  final String id;
  final String name;
  final List<ReferenceGroup> referenceGroups;

  ReferenceCollection(this.id, this.name, this.referenceGroups);
}

class CollectionReference {
  final String id;
  final String name;
  CollectionReference(this.id, this.name);

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(other) {
    if (other is! CollectionReference) {
      return false;
    }
    return id == id && name == name;
  }

  @override
  int get hashCode => (id + name).hashCode;
}

//data
class DataGroup {
  String id;
  DateTime date;
  final List<DataPoint> dataPoints;

  DataGroup(this.id, this.date, this.dataPoints);
  DataGroup.local(this.date, this.dataPoints) : id = "local";

  ReferenceGroup toReferenceGroup() {
    List<DataPointReference> dataReferences = [];
    for (DataPoint dataPoint in dataPoints) {
      dataReferences.add(dataPoint.toDataPointReference());
    }
    return ReferenceGroup(id, date, dataReferences);
  }
}

class ReferenceGroup {
  final String id;
  final DateTime date;
  final List<DataPointReference> dataReferences;

  ReferenceGroup(this.id, this.date, this.dataReferences);
}

class DataPoint {
  String id;
  NamedType namedType;
  String value;
  DataPoint(this.id, this.namedType, this.value);
  DataPoint.local(this.namedType, this.value) : id = "local";
  DataPoint.blank() : id = "local", namedType = NamedType.blank(), value = "";

  DataPointReference toDataPointReference() {
    return DataPointReference.fromDataPoint(this);
  }
}

class DataPointReference {
  final String id;
  final NamedType namedType;

  DataPointReference(this.id, this.namedType);
  DataPointReference.fromDataPoint(DataPoint data)
      : id = data.id,
        namedType = data.namedType;
}
