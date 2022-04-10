import 'package:easyt/data/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateCollectionForm extends StatefulWidget {
  const CreateCollectionForm({Key? key}) : super(key: key);

  @override
  State<CreateCollectionForm> createState() => _CreateCollectionFormState();
}

class _CreateCollectionFormState extends State<CreateCollectionForm> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  void _createCollection() {
    if (_formKey.currentState!.validate()) {
      Provider.of<DataProvider>(context, listen: false)
          .createCollection(_controller.text);
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
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            autofocus: true,
            decoration: const InputDecoration(
                border: UnderlineInputBorder(), labelText: "Collection name"),
            controller: _controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please give a name!";
              }
              return null;
            },
          ),
          ElevatedButton(
              onPressed: _createCollection, child: const Text("Create"))
        ],
      ),
    );
  }
}
