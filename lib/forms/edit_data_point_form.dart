import 'package:auto_route/auto_route.dart';
import 'package:easyt/data/data.dart';
import 'package:easyt/data/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditDataPointForm extends StatefulWidget {
  final String collectionId;
  final String groupId;
  final String dataId;

  const EditDataPointForm(
      {Key? key,
      required this.collectionId,
      required this.groupId,
      required this.dataId})
      : super(key: key);

  @override
  State<EditDataPointForm> createState() => _EditDataPointFormState();
}

class _EditDataPointFormState extends State<EditDataPointForm> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    try {
      DataPoint dataPoint = Provider.of<DataProvider>(context)
          .getDataPoint(widget.collectionId, widget.groupId, widget.dataId);
      _controller.text = dataPoint.value;
      return Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Provider.of<DataProvider>(context, listen: false)
                    .deleteDataPoint(
                        widget.collectionId, widget.groupId, dataPoint.id);
                AutoRouter.of(context).pop();
              },
              child: const Icon(Icons.remove)),
          TextFormField(
            decoration: const InputDecoration(
                border: UnderlineInputBorder(), labelText: "Data point value"),
            controller: _controller,
            onChanged: (text) {
              dataPoint.value = text;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please give a value!";
              }
              return null;
            },
          ),
          ElevatedButton(
              onPressed: () {
                Provider.of<DataProvider>(context, listen: false).editDataPoint(
                    widget.collectionId,
                    widget.groupId,
                    dataPoint.id,
                    _controller.text);
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
