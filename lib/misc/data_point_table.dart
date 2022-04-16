import 'package:auto_route/auto_route.dart';
import 'package:easyt/data/data.dart';
import 'package:easyt/data/provider.dart';
import 'package:easyt/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataPointTable extends StatelessWidget {
  final String collectionId;
  const DataPointTable({Key? key, required this.collectionId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReferenceCollection collection = Provider.of<DataProvider>(context)
        .getReferenceCollection(collectionId, 100, ""); // TODO: pagination
    Map<int, DataRow> tempRows = {};
    Map<int, DataColumn> tempColumns = {
      0: const DataColumn(label: Text("Date"))
    };
    Map<NamedType, int> columnMap = {};
    for (ReferenceGroup referenceGroup in collection.referenceGroups) {
      for (DataPointReference reference in referenceGroup.dataReferences) {
        if (!columnMap.keys.contains(reference.namedType)) {
          int newIndex = 1;
          if (columnMap.values.isNotEmpty) {
            newIndex = columnMap.values.last + 1;
          }
          columnMap[reference.namedType] = newIndex;
          tempColumns[newIndex] =
              DataColumn(label: Text(reference.namedType.name));
        }
      }
    }
    int rowIndex = 0;
    while (rowIndex <= collection.referenceGroups.length - 1) {
      ReferenceGroup referenceGroup = collection.referenceGroups[rowIndex];
      if (tempRows[rowIndex] != null) {
        tempRows[rowIndex]?.cells[0] =
            DataCell(Text(referenceGroup.date.toString()));
        for (DataPointReference reference in referenceGroup.dataReferences) {
          DataPoint dataPoint = Provider.of<DataProvider>(context)
              .getDataPoint(collection.id, referenceGroup.id, reference.id);
          tempRows[rowIndex]?.cells[columnMap[reference.namedType] ?? 1] =
              DataCell(
            Text(dataPoint.value),
            onLongPress: () => AutoRouter.of(context).push(EditDataPointRoute(collectionId: collection.id, groupId: referenceGroup.id, dataId: dataPoint.id)),
          );
        }
        rowIndex++;
      } else {
        tempRows[rowIndex] =
            DataRow(cells: List.filled(tempColumns.length, DataCell.empty));
      }
    }
    List<DataRow> rows =
        List.filled(tempRows.entries.length, const DataRow(cells: []));
    for (MapEntry entry in tempRows.entries) {
      rows[entry.key] = entry.value;
    }
    List<DataColumn> columns = List.filled(
        tempColumns.entries.length, const DataColumn(label: Text("unknown")));
    for (MapEntry entry in tempColumns.entries) {
      columns[entry.key] = entry.value;
    }
    if (columns.isNotEmpty && rows.isNotEmpty) {
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(columns: columns, rows: rows)));
    } else {
      return const Text("Empty collection");
    }
  }
}
