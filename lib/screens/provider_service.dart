import 'package:flutter/material.dart';

class ProviderService extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrease() {
    _count--;
    notifyListeners();
  }

  void reset() {
    _count--;
    notifyListeners();
  }
}
