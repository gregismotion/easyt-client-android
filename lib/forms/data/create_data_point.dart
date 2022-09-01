import 'package:easyt/data/data.dart';
import 'package:easyt/data/provider.dart';
import 'package:easyt/forms/data/data_point_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoFreeNamedType implements Exception {
  final String msg;
  const NoFreeNamedType(this.msg);
  @override
  String toString() => 'There are no more free named types: $msg';
}

class CreateDataPointWidget extends StatefulWidget {
  final DataPoint dataPoint;
  final Function() deleteCallback;
  final Function(NamedType, bool) namedTypeCallback;
  final bool Function(NamedType) isUsedNamedTypeCallback;
  final Function() onError;

  const CreateDataPointWidget(
      {Key? key,
      required this.dataPoint,
      required this.deleteCallback,
      required this.namedTypeCallback,
      required this.isUsedNamedTypeCallback,
      required this.onError})
      : super(key: key);

  @override
  State<CreateDataPointWidget> createState() => _CreateDataPointWidgetState();
}

class _CreateDataPointWidgetState extends State<CreateDataPointWidget> {
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<NamedType>> items = [];
    for (NamedType namedType
        in Provider.of<TypeProvider>(context).getNamedTypes(100, "")) {
      // TODO: proper pagination!
      if (!widget.isUsedNamedTypeCallback(namedType) ||
          namedType == widget.dataPoint.namedType) {
        items.add(DropdownMenuItem<NamedType>(
          child: Text(namedType.name),
          value: namedType,
        ));
      }
    }
    bool isProperNamedType = false;
    for (DropdownMenuItem<NamedType> item in items) {
      if (item.value == widget.dataPoint.namedType) {
        isProperNamedType = true;
      }
    }
    try {
      if (!isProperNamedType) {
        try {
          widget.dataPoint.namedType = items[0].value!;
          widget.namedTypeCallback(widget.dataPoint.namedType, false);
        } on RangeError {
          throw const NoFreeNamedType(
              "Cannot create data point creation form!");
        }
      }
    } on NoFreeNamedType {
      widget.onError();
      return const SizedBox.shrink(); // NOTE: ngl pretty hacky?
    }
    return Column(
      children: [
        ElevatedButton(
            onPressed: widget.deleteCallback, child: const Icon(Icons.remove)),
        DataPointTextFormField(
          basicType: widget.dataPoint.namedType.basicType,
          onChanged: (value) => widget.dataPoint.value = value,
        ),
        DropdownButtonFormField<NamedType>(
            items: items,
            onChanged: (value) {
              NamedType namedType =
                  (value ?? items[0].value)!; // NOTE: is this safe?
              widget.namedTypeCallback(namedType, true);
              widget.dataPoint.namedType = namedType;
            },
            value: widget.dataPoint.namedType),
        const Divider(
            thickness: 2,
            color: Color.fromARGB(255, 0, 0, 0)) // TODO: proper themeing
      ],
    );
  }
}
