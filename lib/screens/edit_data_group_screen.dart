import 'package:auto_route/auto_route.dart';
import 'package:easyt/forms/edit_data_group_form.dart';
import 'package:flutter/material.dart';

class EditDataGroupScreen extends StatelessWidget {
  final String collectionId;
  final String groupId;
  final String
      currentDate; // NOTE: come ooooon, why can't it (de)serialize automatically......................

  const EditDataGroupScreen(
      {Key? key,
      @PathParam("collectionId") required this.collectionId,
      @PathParam("groupId") required this.groupId,
      @PathParam("currentDate") required this.currentDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EditDataGroupForm(
      collectionId: collectionId,
      groupId: groupId,
      currentDate: DateTime.parse(currentDate),
    );
  }
}
