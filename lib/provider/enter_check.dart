import 'package:flutter/material.dart';

class EnterCheck extends ChangeNotifier {
  bool isEntered = false;
  bool isCreatedRoom=false;

  void Enter() {
    isEntered = true;
    notifyListeners();
  }

  void Exit() {
    isEntered = false;
    notifyListeners();
  }

  void EnterCreateRoom(){
    isCreatedRoom=true;
    notifyListeners();
  }

  void CancelCreateRoom(){
    isCreatedRoom=false;
    notifyListeners();
  }

  void CreateRoom(){
    isCreatedRoom=false;
    isEntered=true;
    notifyListeners();
  }

}
