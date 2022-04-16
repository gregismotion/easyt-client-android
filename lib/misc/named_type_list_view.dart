import 'package:easyt/data/data.dart';
import 'package:easyt/misc/named_type_tile.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NamedTypeListView extends StatelessWidget {
  final PagingController<String, NamedType> controller;
  const NamedTypeListView({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PagedListView<String, NamedType>.separated(
      pagingController: controller,
      padding: const EdgeInsets.all(16),
      builderDelegate: // TODO: error indicators
          PagedChildBuilderDelegate(itemBuilder: (context, namedType, i) {
        return NamedTypeTile(namedTypeId: namedType.id);
      }),
      separatorBuilder: (context, i) => const Divider(
        thickness: 2,
        color: Color.fromARGB(255, 0, 0, 0),
      ), // TODO: theme
    );
  }
}
