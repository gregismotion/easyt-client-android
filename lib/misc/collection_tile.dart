import 'package:auto_route/auto_route.dart';
import 'package:easyt/data/provider.dart';
import 'package:easyt/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionTile extends StatelessWidget {
  final String collectionId;

  const CollectionTile({Key? key, required this.collectionId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String collectionName = Provider.of<CollectionProvider>(context)
        .getReferenceCollection(collectionId, 0, "")
        .name;
    return ListTile(
      title: Text(collectionName),
      onTap: () => AutoRouter.of(context)
          .push(CollectionRoute(collectionId: collectionId)),
      onLongPress: () => AutoRouter.of(context).push(EditCollectionRoute(
          collectionId: collectionId, currentName: collectionName)),
    );
  }
}
