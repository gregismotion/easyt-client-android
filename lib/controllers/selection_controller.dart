import 'package:flutter/widgets.dart';

class SelectionController<Reference> extends ChangeNotifier {
  bool isSelectionMode = false;
  List<Reference> selected = [];

  void cancelSelection() {
    isSelectionMode = false;
    selected.clear();
    notifyListeners();
  }

  void selectionChanged(Reference element, bool isSelected) {
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
