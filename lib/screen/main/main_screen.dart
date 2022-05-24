import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runnin_us/screen/waitingroom/create_waiting_room.dart';
import 'package:runnin_us/provider/enter_check.dart';
import 'package:runnin_us/screen/waitingroom/entered_room_screen.dart';
import 'package:runnin_us/screen/waitingroom/waiting_room_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<EnterCheck>(
      builder: (context, provider, child) {
        return isEntered
            ? EnteredWaitingRoom()
            : Provider.of<EnterCheck>(context).isCreatedRoom
                ? CreateWaitingRoom()
                : WaitingRoomScreen();
      },
    );
  }
}
