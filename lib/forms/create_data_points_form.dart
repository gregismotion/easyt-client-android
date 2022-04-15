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
  DataGroup dataGroup = DataGroup.local(DateTime.now(), []);

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
    Navigator.pop(context);
  }

  void _addDataPoint() {
    if (namedTypes.isNotEmpty) {
      setState(() {
        dataGroup.dataPoints.add(DataPoint.local(namedTypes[0], ""));
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: dataGroup.date,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1948, 3, 15),
        lastDate: DateTime(9999, 1, 1));
    if (date != null) {
      TimeOfDay time = await showTimePicker(
              context: context, initialTime: TimeOfDay.now()) ??
          TimeOfDay.fromDateTime(dataGroup.date);
      dataGroup.date =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (DataPoint dataPoint in dataGroup.dataPoints) {
      children.add(CreateDataPointWidget(
        namedTypes: namedTypes,
        dataPoint: dataPoint,
      ));
    }
    children.addAll([
      ElevatedButton(onPressed: _addDataPoint, child: const Icon(Icons.add)),
      ElevatedButton(
          onPressed: () {
            _selectTime(context);
          },
          child: const Icon(Icons.calendar_month)),
      ElevatedButton(onPressed: _createDataPoints, child: const Text("Create"))
    ]);
    return Form(
      key: _formKey,
      child: Column(children: children),
    );
  }
}
