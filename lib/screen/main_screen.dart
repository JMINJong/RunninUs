import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runnin_us/googlemap/on_runnin.dart';
import 'package:runnin_us/provider/enter_check.dart';
import 'package:runnin_us/screen/entered_room_screen.dart';
import 'package:runnin_us/screen/waiting_room_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<EnterCheck>(
      builder: (context, provider, child) {
        return Provider.of<EnterCheck>(context).isEntered
            ? EnteredWaitingRoom()
            : WaitingRoomScreen();
      },
    );
  }
}
