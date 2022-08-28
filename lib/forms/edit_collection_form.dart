import 'dart:async';

import 'package:easyt/data/provider.dart';
import 'package:easyt/forms/edit_unit_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditCollectionForm extends EditUnitForm {
  final String collectionId;
  final void Function(String) collectionDeleted;

  final String collectionCurrentName;
  final Stream collectionEditStream;

  const EditCollectionForm(
      {Key? key,
      required this.collectionId,
      required this.collectionDeleted,
      required this.collectionCurrentName,
      required this.collectionEditStream})
      : super(
            key: key,
            labelText: "Collection name",
            id: collectionId,
            currentName: collectionCurrentName,
            editStream: collectionEditStream,
            deleted: collectionDeleted);

  @override
  _EditCollectionFormState createState() => _EditCollectionFormState();
}

class _EditCollectionFormState extends EditUnitFormState {
  @override
  void edit(String id, String name) {
    Provider.of<CollectionProvider>(context, listen: false)
        .editCollection(id, name);
  }

  @override
  void delete(String id) {
    Provider.of<CollectionProvider>(context, listen: false)
        .deleteCollection(id);
  }
}
