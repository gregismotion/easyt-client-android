import 'package:auto_route/auto_route.dart';
import 'package:easyt/data/data.dart';
import 'package:easyt/data/provider.dart';
import 'package:easyt/misc/data/data_point_table.dart';
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
    return Column(children: [
      Row(
        children: [Text(collection.name)],
      ),
      DataPointTable(collectionId: collectionId)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    ReferenceCollection collection = Provider.of<CollectionProvider>(context)
        .getReferenceCollection(collectionId, 0, "");
    context.watch<DataProvider>();
    context.watch<TypeProvider>();
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
