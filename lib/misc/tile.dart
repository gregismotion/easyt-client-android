import 'package:easyt/controllers/selection_controller.dart';
import 'package:flutter/material.dart';

class Tile<Reference> extends StatefulWidget {
  final SelectionController<Reference> internalSelectionController;

  const Tile({Key? key, required this.internalSelectionController})
      : super(key: key);

  @override
  State<Tile> createState() => TileState();
}

class TileState<Reference, T extends Tile> extends State<T> {
  late Reference reference;

  bool _isSelected = false;
  bool get isSelected {
    if (!widget.internalSelectionController.isSelectionMode &&
        _isSelected == true) {
      _isSelected = false;
    }
    return _isSelected;
  }

  set isSelected(bool current) {
    _isSelected = current;
  }

  void _switchSelection(Reference reference) {
    setState(() {
      isSelected = !isSelected;
      widget.internalSelectionController.selectionChanged(reference,
          _isSelected); // NOTE: as we add the element to the selected items now, we can't use the normal getter as it would turn our selection off, as it isn't in the list yet...
    });
  }

  void _onTapWrapper(Function onTap) {
    if (widget.internalSelectionController.isSelectionMode) {
      _switchSelection(reference);
    } else {
      onTap();
    }
  }

  void onTap() {}

  @override
  void dispose() {
    widget.internalSelectionController.removeListener(() {});
    super.dispose();
  }

  @override
  void initState() {
    widget.internalSelectionController.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: isSelected,
      title: Text(reference.toString()),
      onTap: () => _onTapWrapper(onTap),
      onLongPress: () {
        _switchSelection(reference);
      },
    );
  }
}
