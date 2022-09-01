import 'package:auto_route/auto_route.dart';
import 'package:easyt/data/data.dart';
import 'package:easyt/data/provider.dart';
import 'package:easyt/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataPointTableSource extends DataTableSource {
  int pageSize = 10;

  BuildContext context;
  String collectionId;

  List<ReferenceGroup> referenceGroups = [];
  String lastId = "";

  DataPointTableSource(this.context, this.collectionId) {
    Provider.of<DataProvider>(context).addListener(() {
      rowCount = Provider.of<CollectionProvider>(context, listen: false)
          .getDataGroupCount(collectionId);
      notifyListeners();
    });
  }

  @override
  void dispose() {
    Provider.of<DataProvider>(context).removeListener(() {});
    super.dispose();
  }

  bool fetchPage() {
    referenceGroups.addAll(
        Provider.of<CollectionProvider>(context, listen: false)
            .getReferenceCollection(collectionId, pageSize, lastId)
            .referenceGroups);
    try {
      lastId = referenceGroups.last.id;
      return true;
    } on StateError {
      return false;
    }
  }

  // TODO: error handling
  @override
  DataRow? getRow(int index) {
    if (index >= referenceGroups.length) {
      if (!fetchPage() || index >= referenceGroups.length) {
        return null;
      }
    }
    List<DataCell> cells = List.filled(columnMap.length + 1, DataCell.empty);
    ReferenceGroup referenceGroup = referenceGroups[index];
    cells[0] = (DataCell(Text(referenceGroup.date.toString()),
        onLongPress: () => AutoRouter.of(context).push(EditDataGroupRoute(
            collectionId: collectionId,
            groupId: referenceGroup.id,
            currentDate: referenceGroup.date.toString()))));
    for (DataPointReference reference in referenceGroup.dataReferences) {
      DataPoint dataPoint = Provider.of<DataProvider>(context)
          .getDataPoint(collectionId, referenceGroup.id, reference.id);
      cells[columnMap[reference.namedType] ?? 1] = DataCell(
        Text(dataPoint.value),
        onLongPress: () => AutoRouter.of(context).push(EditDataPointRoute(
            collectionId: collectionId,
            groupId: referenceGroup.id,
            dataId: dataPoint.id)),
      );
    }
    return DataRow(cells: cells);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int rowCount = 0;

  @override
  int get selectedRowCount => 0;

  Map<NamedType, int> get columnMap {
    Map<NamedType, int> map = {};
    for (ReferenceGroup referenceGroup in referenceGroups) {
      for (DataPointReference reference in referenceGroup.dataReferences) {
        if (!map.keys.contains(reference.namedType)) {
          int newIndex = 1;
          if (map.values.isNotEmpty) {
            newIndex = map.values.last + 1;
          }
          map[reference.namedType] = newIndex;
        }
      }
    }
    return map;
  }
}
