import 'package:auto_route/annotations.dart';
import 'package:easyt/forms/edit_named_type_form.dart';
import 'package:flutter/material.dart';

class EditNamedTypeScreen extends StatelessWidget {
  final String namedTypeId;
  final String currentValue;

  const EditNamedTypeScreen(
      {Key? key,
      @PathParam(":namedTypeId") required this.namedTypeId,
      @PathParam(":currentValue") required this.currentValue})
      : super(key: key);

  Widget _buildForm() {
    return EditNamedTypeForm(
        namedTypeId: namedTypeId, currentValue: currentValue);
  }

  @override
  Widget build(BuildContext context) {
    return _buildForm();
  }
}
