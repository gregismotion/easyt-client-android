import 'package:data_table_2/data_table_2.dart';
import 'package:easyt/data/data.dart';
import 'package:easyt/misc/data_point_table_source.dart';
import 'package:flutter/material.dart';

class DataPointTable extends StatefulWidget {
  final String collectionId;
  const DataPointTable({Key? key, required this.collectionId})
      : super(key: key);

  @override
  State<DataPointTable> createState() => _DataPointTableState();
}

class _DataPointTableState extends State<DataPointTable> {
  late DataPointTableSource source =
      DataPointTableSource(context, widget.collectionId);

  @override
  Widget build(BuildContext context) {
    source.fetchPage();
    List<DataColumn> columns = List.filled(
        source.columnMap.length + 1, const DataColumn(label: Text("unknown")));
    columns[0] = const DataColumn(label: Text("Date"));
    for (MapEntry<NamedType, int> entry in source.columnMap.entries) {
      columns[entry.value] = DataColumn(label: Text(entry.key.name));
    }
    if (columns.isNotEmpty) {
      return Expanded(
        child: Column(
          children: [
            Expanded(
              // TODO: proper infinite scroll table
              child: PaginatedDataTable2(
                columns: columns,
                source: source,
              ),
            ),
            const SizedBox(
              height: 75,
            )
          ],
        ),
      );
      ;
    } else {
      return const Text("Collection has no named types!");
    }
  }
}
