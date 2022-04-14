class NotFound implements Exception {
  final String msg;
  const NotFound(this.msg);
  @override
  String toString() => 'NotFound: $msg';
}

abstract class Data {
  // types
  List<BasicType> getBasicTypes();
  List<NamedType> getNamedTypes(int size, String lastId);
  NamedType getNamedType(String id);
  NamedType createNamedType(NamedType namedType);
  void deleteNamedType(String id);

  //collections
  List<CollectionReference> getCollectionReferences(int size, String lastId);
  ReferenceCollection getReferenceCollection(
      String id, int size, String lastId);
  CollectionReference createCollection(String name);
  void deleteCollection(String id);

  //data
  DataPoint getDataPoint(String colId, String groupId, String dataId);
  ReferenceGroups addDataGroup(String colId, DataGroup dataGroup);
  void deleteDataPoint(String colId, groupId, dataId);
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
  final String name;
  final BasicType basicType;

  NamedType(this.id, this.name, this.basicType);
  NamedType.local(this.name, this.basicType) : id = "local";
}

// collections
class ReferenceCollection {
  final String id;
  final String name;
  final ReferenceGroups data;

  ReferenceCollection(this.id, this.name, this.data);
}

class CollectionReference {
  final String id;
  final String name;
  CollectionReference(this.id, this.name);
}

//data
typedef DataGroup = List<DataPoint>;
typedef DataGroups = Map<String, DataGroup>;
typedef ReferenceGroup = List<DataPointReference>;
typedef ReferenceGroups = Map<String, ReferenceGroup>;

class DataPoint {
  final String id;
  final NamedType namedType;
  final DateTime time;
  final String value;
  DataPoint(this.id, this.namedType, this.time, this.value);
  DataPoint.local(this.namedType, this.time, this.value) : id = "local";

  DataPointReference toDataPointReference() {
    return DataPointReference.fromDataPoint(this);
  }
}

class DataPointReference {
  final String id;
  final NamedType namedType;
  final DateTime time;
  DataPointReference(this.id, this.namedType, this.time);
  DataPointReference.fromDataPoint(DataPoint data)
      : id = data.id,
        namedType = data.namedType,
        time = data.time;
}
