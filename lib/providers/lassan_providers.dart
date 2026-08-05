import 'package:flutter/material.dart';
import 'package:todo_ji/models/lassan_models.dart';

class LassanProviders extends ChangeNotifier {
  List<LassanModels> Lassan = [
    LassanModels(id: 1, name: "madar", swearWord: "chud"),
  ];

  void addLassan({
    required int id,
    required String name,
    required String swearWord,
  }) {
    Lassan.add(LassanModels(id: id, name: name, swearWord: swearWord));
    notifyListeners();
  }

  void deleteLassan(int id) {
    Lassan.removeWhere((n) => n.id == id);
    notifyListeners();
  }

  void editlassan({
    required int id,
    required String name,
    required String swearWord,
  }) {
    final index = Lassan.indexWhere((i) => i.id == id);
    if (index != -1) {
      Lassan[index] = LassanModels(id: id, name: name, swearWord: swearWord);
      notifyListeners();
    }
  }
}
