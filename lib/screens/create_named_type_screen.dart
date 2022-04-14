import 'package:easyt/forms/create_named_type_form.dart';
import 'package:flutter/material.dart';

class CreateNamedTypeScreen extends StatelessWidget {
  const CreateNamedTypeScreen({Key? key}) : super(key: key);

  Widget _buildForm() {
    return const CreateNamedTypeForm();
  }

  @override
  Widget build(BuildContext context) {
    return _buildForm();
  }
}
