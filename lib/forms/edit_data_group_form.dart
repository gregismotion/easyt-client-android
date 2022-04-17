import 'package:auto_route/auto_route.dart';
import 'package:easyt/data/data.dart';
import 'package:easyt/data/provider.dart';
import 'package:easyt/misc/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditDataGroupForm extends StatefulWidget {
  final String collectionId;
  final String groupId;
  final DateTime currentDate;

  const EditDataGroupForm({
    Key? key,
    required this.collectionId,
    required this.groupId,
    required this.currentDate
  }) : super(key: key);

  @override
  State<EditDataGroupForm> createState() => _EditDataGroupFormState();
}

class _EditDataGroupFormState extends State<EditDataGroupForm> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    try {
      return Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Provider.of<DataProvider>(context, listen: false)
                    .deleteDataGroup(widget.collectionId, widget.groupId);
                AutoRouter.of(context).pop();
              },
              child: const Icon(Icons.remove)),
          DateTimePicker(
              onChanged: (date) => this.date = date, initialDate: widget.currentDate),
          ElevatedButton(
              onPressed: () {
                Provider.of<DataProvider>(context, listen: false)
                    .editDataGroup(widget.collectionId, widget.groupId, date);
                AutoRouter.of(context).pop();
              },
              child: const Icon(Icons.edit)),
        ],
      );
    } on NotFound {
      return const Text("Data point does not exist!");
    }
  }
}
