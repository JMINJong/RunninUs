import 'package:flutter/material.dart';

class EnterCheck extends ChangeNotifier {
  bool isEntered = false;

  void Enter() {
    isEntered = true;
    notifyListeners();
  }

  void Exit() {
    isEntered = false;
    notifyListeners();
  }
}
