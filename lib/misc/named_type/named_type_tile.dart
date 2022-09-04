import 'package:auto_route/auto_route.dart';
import 'package:easyt/controllers/selection_controller.dart';
import 'package:easyt/data/data.dart';
import 'package:easyt/data/provider.dart';
import 'package:easyt/misc/list/tile.dart';
import 'package:easyt/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class NamedTypeTile extends Tile<dynamic> {
  final String namedTypeId;
  final SelectionController<dynamic>
      selectionController; // FIXME: would be good to provide type safety...

  NamedTypeTile(
      {Key? key, required this.namedTypeId, required this.selectionController})
      : super(key: key, internalSelectionController: selectionController);

  @override
  _NamedTypeTileState createState() => _NamedTypeTileState();
}

class _NamedTypeTileState extends TileState<NamedType, NamedTypeTile> {
  @override
  void onTap() {
    AutoRouter.of(context).push(NamedTypeRoute(namedTypeId: widget.namedTypeId));
  }

  @override
  Widget build(BuildContext context) {
    reference =
        Provider.of<TypeProvider>(context).getNamedType(widget.namedTypeId);
    return super.build(context);
  }
}
