import 'dart:async';

import 'package:easyt/data/provider.dart';
import 'package:easyt/forms/edit_unit_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditNamedTypeForm extends EditUnitForm {
  final String namedTypeId;
  final void Function(String) namedTypeDeleted;

  final String namedTypeCurrentName;
  final Stream namedTypeEditStream;

  const EditNamedTypeForm(
      {Key? key,
      required this.namedTypeId,
      required this.namedTypeDeleted,
      required this.namedTypeCurrentName,
      required this.namedTypeEditStream})
      : super(
            key: key,
            labelText: "Named type name",
            id: namedTypeId,
            currentName: namedTypeCurrentName,
            editStream: namedTypeEditStream,
            deleted: namedTypeDeleted);

  @override
  _EditNamedTypeFormState createState() => _EditNamedTypeFormState();
}

class _EditNamedTypeFormState extends EditUnitFormState {
  @override
  void edit(String id, String name) {
    Provider.of<TypeProvider>(context, listen: false).editNamedType(id, name);
  }

  @override
  void delete(String id) {
    Provider.of<TypeProvider>(context, listen: false).deleteNamedType(id);
  }
}
