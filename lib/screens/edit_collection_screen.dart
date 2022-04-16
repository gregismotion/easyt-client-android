import 'package:easyt/forms/edit_collection_form.dart';
import 'package:flutter/material.dart';

class EditCollectionScreen extends StatelessWidget {
  final String collectionId;
  final String currentName;
  const EditCollectionScreen(
      {Key? key, required this.collectionId, required this.currentName})
      : super(key: key);

  Widget _buildForm() {
    return EditCollectionForm(
        collectionId: collectionId, currentName: currentName);
  }

  @override
  Widget build(BuildContext context) {
    return _buildForm();
  }
}
