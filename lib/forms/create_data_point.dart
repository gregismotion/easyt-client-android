import 'package:easyt/data/data.dart';
import 'package:easyt/data/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateDataPointWidget extends StatefulWidget {
  final DataPoint dataPoint;
  final void Function() deleteCallback;

  const CreateDataPointWidget(
      {Key? key, required this.dataPoint, required this.deleteCallback})
      : super(key: key);

  @override
  State<CreateDataPointWidget> createState() => _CreateDataPointWidgetState();
}

class _CreateDataPointWidgetState extends State<CreateDataPointWidget> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<NamedType>> items = [];
    for (NamedType namedType
        in Provider.of<TypeProvider>(context).getNamedTypes(100, "")) {
      // TODO: proper pagination!
      items.add(DropdownMenuItem<NamedType>(
        child: Text(namedType.name),
        value: namedType,
      ));
    }
    return Column(
      children: [
        ElevatedButton(
            onPressed: widget.deleteCallback, child: const Icon(Icons.remove)),
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
              widget.dataPoint.namedType =
                  (value ?? items[0].value)!; // NOTE: is this safe?
            },
            value: widget.dataPoint.namedType),
        const Divider(
            thickness: 2,
            color: Color.fromARGB(255, 0, 0, 0)) // TODO: proper themeing
      ],
    );
  }
}
