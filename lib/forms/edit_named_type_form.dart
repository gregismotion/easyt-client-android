import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easyt/data/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditNamedTypeForm extends StatefulWidget {
  final String namedTypeId;
  final String currentValue;
  final Stream editStream;

  const EditNamedTypeForm(
      {Key? key,
      required this.namedTypeId,
      required this.currentValue,
      required this.editStream})
      : super(key: key);

  @override
  State<EditNamedTypeForm> createState() => _EditNamedTypeFormState();
}

// TODO: generalize with edit_collection_form...
class _EditNamedTypeFormState extends State<EditNamedTypeForm> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  late StreamSubscription editSubscription;

  void _listenToEdit() {
    editSubscription = widget.editStream.listen((_) => _editNamedType());
  }

  void _stopListenToEdit() {
    editSubscription.cancel();
  }

  @override
  void initState() {
    super.initState();
    _listenToEdit();
  }

  void _editNamedType() {
    if (_formKey.currentState!.validate()) {
      Provider.of<TypeProvider>(context, listen: false)
          .editNamedType(widget.namedTypeId, _textController.text);
    }
  }

  @override
  void didUpdateWidget(EditNamedTypeForm old) {
    super.didUpdateWidget(old);
    // in case the stream instance changed, subscribe to the new one
    if (widget.editStream != old.editStream) {
      _stopListenToEdit();
      _listenToEdit();
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _stopListenToEdit();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _textController.text = widget.currentValue;
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          ElevatedButton(
              onPressed: () {
                Provider.of<TypeProvider>(context, listen: false)
                    .deleteNamedType(widget.namedTypeId);
                AutoRouter.of(context).pop();
              },
              child: const Icon(Icons.remove)),
          TextFormField(
            autofocus: true,
            decoration: const InputDecoration(
                border: UnderlineInputBorder(), labelText: "Named type name"),
            controller: _textController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please give a name!";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
