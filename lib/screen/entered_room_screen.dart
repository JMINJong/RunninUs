import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runnin_us/provider/enter_check.dart';

class EnteredWaitingRoom extends StatelessWidget {
  EnteredWaitingRoom({Key? key}) : super(key: key);

  late EnterCheck _enterCheck;
  @override
  Widget build(BuildContext context) {
    _enterCheck=Provider.of<EnterCheck>(context);
    return Container(
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            print('퇴장');
            _enterCheck.Exit();

          },
          child: Text('나가기'),
        ),
      ),
    );
  }
}
