import 'package:easyt/forms/collection/create_collection_form.dart';
import 'package:flutter/material.dart';

class CreateCollectionScreen extends StatelessWidget {
  const CreateCollectionScreen({Key? key}) : super(key: key);

  Widget _buildForm() {
    return const CreateCollectionForm();
  }

  @override
  Widget build(BuildContext context) {
    return _buildForm();
  }
}
