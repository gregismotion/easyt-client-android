import 'package:easyt/controllers/selection_controller.dart';
import 'package:easyt/data/data.dart';
import 'package:easyt/data/provider.dart';
import 'package:easyt/misc/list/tile.dart';
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
    // TODO: implement smt on NamedType onTap
  }

  @override
  Widget build(BuildContext context) {
    reference =
        Provider.of<TypeProvider>(context).getNamedType(widget.namedTypeId);
    return super.build(context);
  }
}

/*class NamedTypeTile extends StatelessWidget {
  final String namedTypeId;

  const NamedTypeTile({Key? key, required this.namedTypeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NamedType namedType =
        
    return ListTile(
      title:
          Text(),
      onLongPress: () => ,
    );
  }
}*/
