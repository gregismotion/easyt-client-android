import 'package:flutter/widgets.dart';

class SelectionController<ValueType> extends ChangeNotifier {
  bool isSelectionMode = false;
  List<ValueType> selected = [];

  void cancelSelection() {
    isSelectionMode = false;
    notifyListeners();
  }

  void selectionChanged(ValueType element, bool isSelected) {
    if (selected.isEmpty) {
      isSelectionMode = true;
    }
    if (isSelected) {
      selected.add(element);
    } else {
      selected.remove(element);
    }
    if (selected.isEmpty) {
      isSelectionMode = false;
    }
    notifyListeners();
  }
}
