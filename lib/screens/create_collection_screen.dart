import 'package:easyt/forms/create_collection_form.dart';
import 'package:flutter/material.dart';

class CreateCollectionScreen extends StatelessWidget {
  const CreateCollectionScreen({Key? key}) : super(key: key);
  static const String route = "/collection/create";

  Widget _buildForm() {
    return const CreateCollectionForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Create a collection"),
        ),
        body: _buildForm());
  }
}
