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
            })
      ],
    );
  }
}
