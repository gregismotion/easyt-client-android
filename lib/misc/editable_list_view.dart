import 'package:easyt/controllers/selection_controller.dart';
import 'package:easyt/misc/tile.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class EditableListView<Reference> extends StatefulWidget {
  final Tile Function(SelectionController, Reference) tileCreator;
  final List<Reference> Function(int, String) fetchReferencePage;
  final String Function(Reference) referenceToKey;
  final void Function(PagingController) setRefreshListener;
  final void Function(List<dynamic>) editReferences; // FIXME: type safety...
  final void Function() createReference;
  final void Function(Widget) changeActionButton;

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
  final _pagingController =
      PagingController<String, Reference>(firstPageKey: "");

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) => _fetchPage(pageKey));
    _selectionController.addListener(() {
      widget.changeActionButton(_getActionButton());
    });
    widget.setRefreshListener(_pagingController);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      widget.changeActionButton(_getActionButton());
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _selectionController.dispose();
    super.dispose();
  }

  void _fetchPage(String pageKey) {
    const int size = 10;
    try {
      final List<Reference> referencePage =
          widget.fetchReferencePage(size, pageKey) as List<Reference>;
      if (referencePage.length < size) {
        _pagingController.appendLastPage(referencePage);
      } else {
        _pagingController.appendPage(
            referencePage, widget.referenceToKey(referencePage.last));
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  Widget _getActionButton() {
    if (_selectionController.isSelectionMode) {
      return FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {
          widget.editReferences(_selectionController.selected);
          _selectionController.cancelSelection();
        },
      );
    } else {
      return FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => widget.createReference(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () => Future.sync(() => _pagingController.refresh()),
        child: PagedListView<String, Reference>.separated(
          pagingController: _pagingController,
          padding: const EdgeInsets.all(16),
          builderDelegate: // TODO: error indicators
              PagedChildBuilderDelegate(itemBuilder: (context, reference, i) {
            return widget.tileCreator(_selectionController, reference);
          }),
          separatorBuilder: (context, i) => const Divider(
            thickness: 2,
            color: Color.fromARGB(255, 0, 0, 0),
          ), // TODO: theme
        ));
  }
}
