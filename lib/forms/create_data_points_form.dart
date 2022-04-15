import 'package:auto_route/annotations.dart';
import 'package:easyt/data/data.dart';
import 'package:easyt/data/provider.dart';
import 'package:easyt/forms/create_data_point.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateDataPointsForm extends StatefulWidget {
  final String collectionId;
  const CreateDataPointsForm(
      {Key? key, @PathParam("collectionId") required this.collectionId})
      : super(key: key);

  @override
  State<CreateDataPointsForm> createState() => _CreateDataPointsFormState();
}

class _CreateDataPointsFormState extends State<CreateDataPointsForm> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  List<NamedType> namedTypes = [];
  DataGroup dataGroup = [];

  @override
  void initState() {
    super.initState();
    namedTypes = Provider.of<DataProvider>(context, listen: false)
        .getNamedTypes(100, ""); // TODO: proper pagination!
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _createDataPoints() {
    Provider.of<DataProvider>(context, listen: false)
        .addDataGroup(widget.collectionId, dataGroup);
  }

  void _addDataPoint() {
    if (namedTypes.isNotEmpty) {
      setState(() {
        dataGroup.add(DataPoint.local(namedTypes[0], DateTime.now(), ""));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (DataPoint dataPoint in dataGroup) {
      children.add(CreateDataPointWidget(
        namedTypes: namedTypes,
        dataPoint: dataPoint,
      ));
    }
    children.addAll([
      ElevatedButton(onPressed: _addDataPoint, child: const Icon(Icons.add)),
      ElevatedButton(onPressed: _createDataPoints, child: const Text("Create"))
    ]);
    return Form(
      key: _formKey,
      child: Column(children: children),
    );
  }
}
