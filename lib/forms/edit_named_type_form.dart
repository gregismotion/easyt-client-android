import 'package:easyt/data/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditNamedTypeForm extends StatefulWidget {
  final String namedTypeId;
  final String currentValue;

  const EditNamedTypeForm(
      {Key? key, required this.namedTypeId, required this.currentValue})
      : super(key: key);

  @override
  State<EditNamedTypeForm> createState() => _EditNamedTypeFormState();
}

class _EditNamedTypeFormState extends State<EditNamedTypeForm> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  void _editNamedType() {
    if (_formKey.currentState!.validate()) {
      Provider.of<DataProvider>(context, listen: false)
          .editNamedType(widget.namedTypeId, _controller.text);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.currentValue;
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            autofocus: true,
            decoration: const InputDecoration(
                border: UnderlineInputBorder(), labelText: "Named type name"),
            controller: _controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please give a name!";
              }
              return null;
            },
          ),
          ElevatedButton(onPressed: _editNamedType, child: const Text("Edit"))
        ],
      ),
    );
  }
}
