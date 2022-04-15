import 'package:auto_route/auto_route.dart';
import 'package:easyt/data/data.dart';
import 'package:easyt/data/provider.dart';
import 'package:easyt/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionScreen extends StatelessWidget {
  final String collectionId;
  const CollectionScreen(
      {Key? key, @PathParam("collectionId") required this.collectionId})
      : super(key: key);

  Widget _buildCollection(
      BuildContext context, ReferenceCollection collection) {
    List<DataRow> rows = [];
    List<DataColumn> columns = [];
    List<NamedType> namedTypes = [];
    for (var entry in collection.data.entries) {
      List<DataCell> cells = [];
      int i = 0;
      for (var dataReference in entry.value) {
        if (!namedTypes.contains(dataReference.namedType)) {
          namedTypes.add(dataReference.namedType);
          columns.add(DataColumn(label: Text(dataReference.namedType.name)));
        }
        if (dataReference.namedType != namedTypes[i]) {
          cells.add(const DataCell(Text("NO DATA!")));
          i++;
        }
        DataPoint data = Provider.of<DataProvider>(context)
            .getDataPoint(collection.id, entry.key, dataReference.id);
        cells.add(DataCell(Text(data.value)));
        i++;
      }
      rows.add(DataRow(cells: cells));
    }
    List<Widget> children = [
      Row(
        children: [Text(collection.name)],
      ),
      Row(
        children: [Text(collection.id)],
      )
    ];
    if (columns.isNotEmpty && rows.isNotEmpty) {
      children.add(DataTable(columns: columns, rows: rows));
    }
    return Column(
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    ReferenceCollection collection = Provider.of<DataProvider>(context)
        .getReferenceCollection(collectionId, 10, "");
    return Scaffold(
      body: _buildCollection(context, collection),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          AutoRouter.of(context)
              .push(CreateDataPointsRoute(collectionId: collection.id));
        },
      ),
    );
  }
}
