import 'dart:async';

import 'package:flutter/material.dart';

class EditUnitForm extends StatefulWidget {
  final String labelText;

  final String id;
  final String currentName;

  final Stream editStream;

  final void Function(String) deleted;

  const EditUnitForm(
      {Key? key,
      required this.labelText,
      required this.id,
      required this.currentName,
      required this.editStream,
      required this.deleted})
      : super(key: key);

  @override
  State<EditUnitForm> createState() => EditUnitFormState();
}

class EditUnitFormState extends State<EditUnitForm>
    with AutomaticKeepAliveClientMixin<EditUnitForm> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  late StreamSubscription editSubscription;

  void _listenToEdit() {
    editSubscription = widget.editStream.listen((_) => _editWrapper());
  }

  void _stopListenToEdit() {
    editSubscription.cancel();
  }

  @override
  void initState() {
    super.initState();
    _listenToEdit();
  }

  void edit(String id, String newName) {}
  void _editWrapper() {
    if (_formKey.currentState!.validate()) {
      edit(widget.id, _textController.text);
    }
  }

  void delete(String id) {}
  void _deleteWrapper() {
    delete(widget.id);
  }

  @override
  void didUpdateWidget(EditUnitForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    // in case the stream instance changed, subscribe to the new one
    if (widget.editStream != oldWidget.editStream) {
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

  bool isNameAlreadySet = false;
  String originalName = "";
  void setName() {
    if (!isNameAlreadySet) {
      originalName = widget.currentName;
    }
    if (!isNameAlreadySet || originalName != widget.currentName) {
      // NOTE: the or is PROBABLY needed because Flutter wants to reuse the widget? I'm not completely sure... Could be connected to the super call in build?
      _textController.text = widget.currentName;
      isNameAlreadySet = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    setName();
    super.build(context);
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          ElevatedButton(
              onPressed: () {
                _deleteWrapper();
                widget.deleted(widget.id);
              },
              child: const Icon(Icons.remove)),
          TextFormField(
            autofocus: true,
            decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: widget.labelText),
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

  @override
  bool get wantKeepAlive => true;
}
