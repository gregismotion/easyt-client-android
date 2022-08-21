import 'package:easyt/misc/tile.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TileListView<Reference> extends StatefulWidget {
  final Tile Function(Reference) tileCreator;
  final List<Reference> Function(int, String) fetchReferencePage;
  final String Function(Reference) referenceToKey;
  final void Function(PagingController) setRefreshListener;

  const TileListView(
      {Key? key,
      required this.tileCreator,
      required this.fetchReferencePage,
      required this.referenceToKey,
      required this.setRefreshListener})
      : super(key: key);

  @override
  State<TileListView> createState() => _TileListViewState();
}

class _TileListViewState<Reference> extends State<TileListView> {
  final _pagingController =
      PagingController<String, Reference>(firstPageKey: "");

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) => _fetchPage(pageKey));
    widget.setRefreshListener(_pagingController);
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

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () => Future.sync(() => _pagingController.refresh()),
        child: PagedListView<String, Reference>.separated(
          pagingController: _pagingController,
          padding: const EdgeInsets.all(16),
          builderDelegate: // TODO: error indicators
              PagedChildBuilderDelegate(itemBuilder: (context, reference, i) {
            return widget.tileCreator(reference);
          }),
          separatorBuilder: (context, i) => const Divider(
            thickness: 2,
            color: Color.fromARGB(255, 0, 0, 0),
          ), // TODO: theme
        ));
  }
}
