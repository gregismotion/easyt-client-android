import 'package:easyt/misc/collection/collection_list_view.dart';
import 'package:easyt/misc/action_button/dynamic_scaffold.dart';
import 'package:flutter/material.dart';

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({Key? key}) : super(key: key);

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  @override
  Widget build(BuildContext context) {
    return DynamicScaffold(body: CollectionListView());
  }
}
