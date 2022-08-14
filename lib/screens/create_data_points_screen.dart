import 'package:auto_route/auto_route.dart';
import 'package:easyt/forms/create_data_points_form.dart';
import 'package:flutter/material.dart';

class CreateDataPointsScreen extends StatelessWidget {
  final String collectionId;
  const CreateDataPointsScreen(
      {Key? key, @PathParam("collectionId") required this.collectionId})
      : super(key: key);


  // TODO: refactor properly
  Widget _buildForm() {
    return CreateDataPointsForm(collectionId: collectionId);
  }

  @override
  Widget build(BuildContext context) {
    return _buildForm();
  }
}
