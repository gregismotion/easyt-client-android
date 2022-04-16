import 'package:auto_route/auto_route.dart';
import 'package:easyt/data/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditCollectionForm extends StatefulWidget {
  final String collectionId;
  final String currentName;
  const EditCollectionForm(
      {Key? key, required this.collectionId, required this.currentName})
      : super(key: key);

  @override
  State<EditCollectionForm> createState() => _EditCollectionFormState();
}

class _EditCollectionFormState extends State<EditCollectionForm> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  void _editCollection() {
    if (_formKey.currentState!.validate()) {
      Provider.of<DataProvider>(context, listen: false)
          .editCollection(widget.collectionId, _controller.text);
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
    _controller.text = widget.currentName;
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          ElevatedButton(
              onPressed: () {
                Provider.of<DataProvider>(context, listen: false)
                    .deleteCollection(widget.collectionId);
                AutoRouter.of(context).pop();
              },
              child: const Icon(Icons.remove)),
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
          ElevatedButton(onPressed: _editCollection, child: const Text("Edit"))
        ],
      ),
    );
  }
}
