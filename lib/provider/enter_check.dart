import 'package:flutter/material.dart';

class EnterCheck extends ChangeNotifier {
  bool isEntered = false;
  bool isCreatedRoom = false;
  bool isHost = false;

  void Enter() {
    isEntered = true;
    notifyListeners();
  }

  void Exit() {
    isEntered = false;
    isHost = false;
    notifyListeners();
  }

  void EnterCreateRoom() {
    isCreatedRoom = true;
    notifyListeners();
  }

  void CancelCreateRoom() {
    isCreatedRoom = false;
    notifyListeners();
  }

  void CreateRoom() {
    isCreatedRoom = false;
    isEntered = true;
    isHost = true;
    notifyListeners();
  }

  void StartRoom() {
    print('방 시작');
    isEntered = false;
    isHost = false;
    notifyListeners();
  }

  void refreshScreen() {
    notifyListeners();
  }
}

class NowEnterCheck extends ChangeNotifier {
  bool isEntered = true;
  bool isCreatedRoom = false;
  bool isHost = false;

  void Enter() {
    isEntered = true;
    notifyListeners();
  }

  void Exit() {
    isEntered = false;
    isHost = false;
    notifyListeners();
  }

  void EnterCreateRoom() {
    isCreatedRoom = true;
    notifyListeners();
  }

  void CancelCreateRoom() {
    isCreatedRoom = false;
    notifyListeners();
  }

  void CreateRoom() {
    isCreatedRoom = false;
    isEntered = true;
    isHost = true;
    notifyListeners();
  }

  void StartRoom() {
    print('방 시작');
    isEntered = false;
    isHost = false;
    notifyListeners();
  }

  void refreshScreen() {
    notifyListeners();
  }
}
