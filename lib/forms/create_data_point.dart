import 'package:easyt/data/data.dart';
import 'package:flutter/material.dart';

class CreateDataPointWidget extends StatefulWidget {
  final List<NamedType> namedTypes;
  final DataPoint dataPoint;

  const CreateDataPointWidget(
      {Key? key, required this.namedTypes, required this.dataPoint})
      : super(key: key);

  @override
  State<CreateDataPointWidget> createState() => _CreateDataPointWidgetState();
}

class _CreateDataPointWidgetState extends State<CreateDataPointWidget> {
  final _controller = TextEditingController();

  Future<void> _selectTime(BuildContext context) async {
    widget.dataPoint.date = await showDatePicker(
            context: context,
            initialDate: widget.dataPoint.date,
            initialDatePickerMode: DatePickerMode.day,
            firstDate: DateTime(1948, 3, 15),
            lastDate: DateTime(9999, 1, 1)) ??
        widget.dataPoint.date;
    TimeOfDay time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now()) ??
            TimeOfDay.fromDateTime(widget.dataPoint.date);
    widget.dataPoint.date = DateTime(
        widget.dataPoint.date.year,
        widget.dataPoint.date.month,
        widget.dataPoint.date.day,
        time.hour,
        time.minute);
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<NamedType>> items = [];
    for (NamedType namedType in widget.namedTypes) {
      items.add(DropdownMenuItem<NamedType>(
        child: Text(namedType.name),
        value: namedType,
      ));
    }
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
              border: UnderlineInputBorder(), labelText: "Data point value"),
          controller: _controller,
          onChanged: (text) {
            widget.dataPoint.value = text;
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please give a value!";
            }
            return null;
          },
        ),
        DropdownButtonFormField<NamedType>(
            items: items,
            onChanged: (value) {
              widget.dataPoint.namedType = value ?? widget.namedTypes[0];
            }),
        ElevatedButton(
            onPressed: () {
              _selectTime(context);
            },
            child: const Icon(Icons.calendar_month))
      ],
    );
  }
}
