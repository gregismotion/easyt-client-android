import 'package:auto_route/annotations.dart';
import 'package:easyt/data/data.dart';
import 'package:easyt/data/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionScreen extends StatelessWidget {
  final String collectionId;
  const CollectionScreen(
      {Key? key, @PathParam("collectionId") required this.collectionId})
      : super(key: key);

  Widget _buildCollection(ReferenceCollection collection) {
    return Column(
      children: [
        Row(
          children: [Text(collection.name)],
        ),
        Row(
          children: [Text(collection.id)],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ReferenceCollection collection = Provider.of<DataProvider>(context)
        .getReferenceCollection(collectionId, 0, "");
    return Scaffold(
      body: _buildCollection(collection),
    );
  }
}
