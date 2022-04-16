import 'package:auto_route/auto_route.dart';
import 'package:easyt/data/data.dart';
import 'package:easyt/data/provider.dart';
import 'package:easyt/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NamedTypeTile extends StatelessWidget {
  final String namedTypeId;

  const NamedTypeTile({Key? key, required this.namedTypeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NamedType namedType =
        Provider.of<TypeProvider>(context).getNamedType(namedTypeId);
    return ListTile(
      title:
          Text("${namedType.name} (${basicTypeToName(namedType.basicType)})"),
      onLongPress: () => AutoRouter.of(context).push(EditNamedTypeRoute(
          namedTypeId: namedType.id, currentValue: namedType.name)),
    );
  }
}
