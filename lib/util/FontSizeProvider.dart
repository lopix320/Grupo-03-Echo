import 'package:flutter/material.dart';

class FontSizeProvider with ChangeNotifier {
  double _fontSize = 14.0; // Tamanho inicial da fonte

  double get fontSize => _fontSize;

  void increaseFontSize() {
    if (_fontSize < 20) {
      _fontSize += 2;
      notifyListeners();
    }
  }

  void decreaseFontSize() {
    if (_fontSize > 10) {
      _fontSize -= 2;
      notifyListeners();
    }
  }
}
