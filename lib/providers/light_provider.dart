import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class LightProvider extends ChangeNotifier {
  bool isOn = false;

  Future<void> toggleLight() async {
    try {
      if (isOn) {
        await TorchLight.disableTorch();
      } else {
        await TorchLight.enableTorch();
      }

      isOn = !isOn;
      notifyListeners();
    } catch (e) {
      throw Exception("Flashlight not available: $e");
    }
  }
}
