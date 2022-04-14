import 'package:auto_route/auto_route.dart';
import 'package:easyt/routes/router.gr.dart';
import 'package:flutter/material.dart';

class CollectionTile extends StatelessWidget {
  final String collectionId;
  final String collectionName;
  const CollectionTile(
      {Key? key, required this.collectionId, required this.collectionName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(collectionName),
      onTap: () {
        AutoRouter.of(context)
            .push(CollectionRoute(collectionId: collectionId));
      },
    );
  }
}
