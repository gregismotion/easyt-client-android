import 'package:easyt/data/data.dart';
import 'package:flutter/material.dart';

class DataPointTextFormField extends StatefulWidget {
  const DataPointTextFormField(
      {Key? key,
      required this.basicType,
      required this.onChanged,
      this.initialValue = ""})
      : super(key: key);

  final BasicType basicType;
  final Function(String) onChanged;
  final String initialValue;

  @override
  State<DataPointTextFormField> createState() => _DataPointTextFormFieldState();
}

class _DataPointTextFormFieldState extends State<DataPointTextFormField> {
  final _controller = TextEditingController();

  TextInputType _getInputType(BasicType basicType) {
    Map<BasicType, TextInputType> basicTypeToInputType = {
      BasicType.num: TextInputType.number,
      BasicType.str: TextInputType.text
    };
    return basicTypeToInputType[basicType] ?? TextInputType.text;
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.initialValue;
    return TextFormField(
      keyboardType: _getInputType(widget.basicType),
      decoration: const InputDecoration(
          border: UnderlineInputBorder(), labelText: "Data point value"),
      controller: _controller,
      onChanged: (text) {
        widget.onChanged(text);
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please give a value!";
        }
        return null;
      },
    );
  }
}
