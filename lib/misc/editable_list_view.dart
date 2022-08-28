import 'package:easyt/controllers/selection_controller.dart';
import 'package:easyt/misc/tile.dart';
import 'package:easyt/misc/tile_list_view.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class EditableListView<Reference> extends StatefulWidget {
  final Tile Function(SelectionController, Reference) tileCreator;
  final List<Reference> Function(int, String) fetchReferencePage;
  final String Function(dynamic) referenceToKey; // FIXME: type safety...
  final void Function(PagingController) setRefreshListener;
  final void Function(List<dynamic>) editReferences; // FIXME: type safety...
  final void Function() createReference;
  final void Function(bool, void Function()) changeActionButton;

  const EditableListView(
      {Key? key,
      required this.tileCreator,
      required this.fetchReferencePage,
      required this.referenceToKey,
      required this.setRefreshListener,
      required this.editReferences,
      required this.createReference,
      required this.changeActionButton})
      : super(key: key);

  @override
  State<EditableListView> createState() => _EditableListViewState();
}

class _EditableListViewState<Reference> extends State<EditableListView> {
  final _selectionController = SelectionController<Reference>();

  @override
  void initState() {
    super.initState();
    _selectionController.addListener(() {
      updateActionButton();
    });
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      updateActionButton();
    });
  }

  void updateActionButton() {
    if (_selectionController.isSelectionMode) {
      widget.changeActionButton(true, () {
        widget.editReferences(_selectionController.selected);
        _selectionController.cancelSelection();
      });
    } else {
      widget.changeActionButton(false, () => widget.createReference());
    }
  }

  @override
  void dispose() {
    _selectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TileListView(
      tileCreator: (dynamic reference) {
        // FIXME: type safety...
        Tile tile = widget.tileCreator(_selectionController, reference);
        tile.internalSelectionController = _selectionController;
        return tile;
      },
      fetchReferencePage: widget.fetchReferencePage,
      referenceToKey: widget.referenceToKey,
      setRefreshListener: widget.setRefreshListener,
    );
  }
}
