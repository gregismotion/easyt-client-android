import 'package:auto_route/auto_route.dart';
import 'package:easyt/data/data.dart';
import 'package:easyt/data/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NamedTypeScreen extends StatelessWidget {
  final String namedTypeId;
  const NamedTypeScreen(
      {Key? key, @PathParam("namedTypeId") required this.namedTypeId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    NamedType namedType =
        Provider.of<TypeProvider>(context).getNamedType(namedTypeId);
    return Column(
      children: [
        Text(namedType.name),
        Text(Provider.of<TypeProvider>(context, listen: false)
            .basicTypeToString(namedType.basicType)),
      ],
    );
  }
}
