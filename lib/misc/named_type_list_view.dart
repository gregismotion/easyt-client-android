import 'package:auto_route/auto_route.dart';
import 'package:easyt/controllers/selection_controller.dart';
import 'package:easyt/data/data.dart';
import 'package:easyt/data/provider.dart';
import 'package:easyt/misc/editable_list_view.dart';
import 'package:easyt/misc/named_type_tile.dart';
import 'package:easyt/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class NamedTypeListView extends StatelessWidget {
  final void Function(bool, void Function()) changeActionButton;
  const NamedTypeListView({Key? key, required this.changeActionButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, String> _referencesToMap(List<dynamic> references) {
      // FIXME: type safety...
      Map<String, String> namedTypes = {};
      for (NamedType reference in references) {
        namedTypes[reference.id] = reference.name;
      }
      return namedTypes;
    }

    EditableListView<NamedType> listView = EditableListView(
      tileCreator:
          (SelectionController selectionController, dynamic reference) {
        return NamedTypeTile(
            namedTypeId: (reference as NamedType).id,
            selectionController:
                selectionController); // FIXME: can't provide type safety as of generics...
      },
      fetchReferencePage: (int size, String pageKey) {
        return Provider.of<TypeProvider>(context, listen: false)
            .getNamedTypes(size, pageKey);
      },
      referenceToKey: (dynamic reference) {
        // FIXME: type safety...
        return reference.id;
      },
      setRefreshListener: (PagingController pagingController) => {
        Provider.of<TypeProvider>(context)
            .addListener(() => pagingController.refresh())
      },
      editReferences: (List<dynamic> references) {
        // FIXME: type safety...
        AutoRouter.of(context).push(
            EditNamedTypesRoute(namedTypes: _referencesToMap(references)));
      },
      createReference: () {
        AutoRouter.of(context).push(const CreateNamedTypeRoute());
      },
      changeActionButton: (bool isEditing, void Function() onPressed) =>
          changeActionButton(isEditing, onPressed),
    );
    return listView;
  }
}
