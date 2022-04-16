import 'package:auto_route/auto_route.dart';
import 'package:easyt/data/data.dart';
import 'package:easyt/data/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../routes/router.gr.dart';

// TODO: switch to infinite_scroll_pagination

class NamedTypesScreen extends StatefulWidget {
  const NamedTypesScreen({Key? key}) : super(key: key);

  @override
  State<NamedTypesScreen> createState() => _NamedTypesScreenState();
}

class _NamedTypesScreenState extends State<NamedTypesScreen> {
  final _namedTypes = <NamedType>[];
  late ScrollController _controller;

  void _scrollListener() {
    if (_controller.position.extentAfter < 500) {
      _namedTypes.addAll(Provider.of<DataProvider>(context, listen: false)
          .getNamedTypes(10, _getLastId()));
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_scrollListener);
  }

  String _getLastId() {
    if (_namedTypes.isNotEmpty) {
      return _namedTypes.last.id;
    }
    return "";
  }

  void _createNamedType() {
    AutoRouter.of(context).push(const CreateNamedTypeRoute());
  }

  Widget _buildNamedType(NamedType namedType) {
    return ListTile(
      title:
          Text("${namedType.name} (${basicTypeToName(namedType.basicType)})"),
      onLongPress: () => AutoRouter.of(context).push(EditNamedTypeRoute(
          namedTypeId: namedType.id, currentValue: namedType.name)),
    );
  }

  Widget _buildNamedTypes() {
    return ListView.builder(
      controller: _controller,
      padding: const EdgeInsets.all(16),
      itemCount: _namedTypes.length * 2, // NOTE: cos divider...
      itemBuilder: (context, i) {
        if (i.isOdd) {
          return const Divider();
        }

        final index = i ~/ 2;
        return _buildNamedType(_namedTypes[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _namedTypes.clear();
    _namedTypes
        .addAll(Provider.of<DataProvider>(context).getNamedTypes(10, ""));
    return Scaffold(
      body: _buildNamedTypes(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _createNamedType,
      ),
    );
  }
}
