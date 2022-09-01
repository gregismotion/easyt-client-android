import 'package:flutter/material.dart';

class DynamicActionButton extends StatefulWidget {
  final bool isEditing;
  final void Function() onPressed;
  const DynamicActionButton(
      {Key? key, required this.isEditing, required this.onPressed})
      : super(key: key);

  @override
  State<DynamicActionButton> createState() => _DynamicActionButtonState();
}

class _DynamicActionButtonState extends State<DynamicActionButton> {
  @override
  Widget build(BuildContext context) {
    Icon icon = const Icon(Icons.add);
    if (widget.isEditing) {
      icon = const Icon(Icons.edit);
    }
    return FloatingActionButton(
        onPressed: () => widget.onPressed(), child: icon);
  }
}
