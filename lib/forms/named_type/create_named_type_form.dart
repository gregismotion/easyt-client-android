import 'package:easyt/data/data.dart';
import 'package:easyt/data/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateNamedTypeForm extends StatefulWidget {
  const CreateNamedTypeForm({Key? key}) : super(key: key);

  @override
  State<CreateNamedTypeForm> createState() => _CreateNamedTypeFormState();
}

class _CreateNamedTypeFormState extends State<CreateNamedTypeForm> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  BasicType _basicType = BasicType.num;

  void _createNamedType() {
    if (_formKey.currentState!.validate()) {
      Provider.of<TypeProvider>(context, listen: false)
          .createNamedType(NamedType.local(_controller.text, _basicType));
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onBasicTypeSelect(BasicType? selectedValue) {
    if (selectedValue != null) {
      _basicType = selectedValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<BasicType>> dropdownBasicTypes = [];
    for (var basicType in BasicType.values) {
      dropdownBasicTypes.add(DropdownMenuItem<BasicType>(
        child: Text(
          basicTypeToName(basicType),
        ),
        value: basicType,
      ));
    }
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
          DropdownButtonFormField(
            items: dropdownBasicTypes,
            onChanged: _onBasicTypeSelect,
            value: BasicType.num,
          ),
          ElevatedButton(
              onPressed: _createNamedType, child: const Text("Create"))
        ],
      ),
    );
  }
}
