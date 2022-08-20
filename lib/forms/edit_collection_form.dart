import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easyt/data/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditCollectionForm extends StatefulWidget {
  final String collectionId;
  final String currentName;
  final Stream editStream;
  const EditCollectionForm(
      {Key? key,
      required this.collectionId,
      required this.currentName,
      required this.editStream})
      : super(key: key);

  @override
  State<EditCollectionForm> createState() => _EditCollectionFormState();
}

class _EditCollectionFormState extends State<EditCollectionForm> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  late StreamSubscription editSubscription;

  void _listenToEdit() {
    editSubscription = widget.editStream.listen((_) => _editCollection());
  }

  void _stopListenToEdit() {
    editSubscription.cancel();
  }

  @override
  void initState() {
    super.initState();
    _listenToEdit();
  }

  void _editCollection() {
    if (_formKey.currentState!.validate()) {
      Provider.of<CollectionProvider>(context, listen: false)
          .editCollection(widget.collectionId, _textController.text);
    }
  }

  @override
  void didUpdateWidget(EditCollectionForm old) {
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
    _textController.text = widget.currentName;
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          ElevatedButton(
              onPressed: () {
                Provider.of<CollectionProvider>(context, listen: false)
                    .deleteCollection(widget.collectionId);
                AutoRouter.of(context).pop();
              },
              child: const Icon(Icons.remove)),
          TextFormField(
            autofocus: true,
            decoration: const InputDecoration(
                border: UnderlineInputBorder(), labelText: "Collection name"),
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
