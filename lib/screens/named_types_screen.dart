import 'package:auto_route/auto_route.dart';
import 'package:easyt/data/data.dart';
import 'package:easyt/data/provider.dart';
import 'package:easyt/misc/named_type_list_view.dart';
import 'package:easyt/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class NamedTypesScreen extends StatefulWidget {
  const NamedTypesScreen({Key? key}) : super(key: key);

  @override
  State<NamedTypesScreen> createState() => _NamedTypesScreenState();
}

class _NamedTypesScreenState extends State<NamedTypesScreen> {
  final _controller = PagingController<String, NamedType>(firstPageKey: "");

  @override
  void initState() {
    super.initState();
    _controller.addPageRequestListener((pageKey) => _fetchPage(pageKey));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _fetchPage(String pageKey) {
    const int size = 10;
    try {
      final List<NamedType> namedTypePage =
          Provider.of<DataProvider>(context, listen: false)
              .getNamedTypes(size, pageKey);
      if (namedTypePage.length < size) {
        _controller.appendLastPage(namedTypePage);
      } else {
        _controller.appendPage(namedTypePage, namedTypePage.last.id);
      }
    } catch (error) {
      _controller.error = error;
    }
  }

  void _createNamedType() {
    AutoRouter.of(context).push(const CreateNamedTypeRoute());
  }

  void _prepareListener() {
    Provider.of<DataProvider>(context).addListener(() => _controller.refresh());
  }

  @override
  Widget build(BuildContext context) {
    _prepareListener();
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: () => Future.sync(() => _controller.refresh()),
          child: NamedTypeListView(controller: _controller)),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _createNamedType,
      ),
    );
  }
}
