import 'package:easyt/misc/action_button/dynamic_scaffold.dart';
import 'package:easyt/misc/named_type/named_type_list_view.dart';
import 'package:flutter/material.dart';

class NamedTypesScreen extends StatefulWidget {
  const NamedTypesScreen({Key? key}) : super(key: key);

  @override
  State<NamedTypesScreen> createState() => _NamedTypesScreenState();
}

class _NamedTypesScreenState extends State<NamedTypesScreen> {
  @override
  Widget build(BuildContext context) {
    return DynamicScaffold(body: NamedTypeListView());
  }
}
