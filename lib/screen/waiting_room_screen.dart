import 'package:flutter/material.dart';
import 'package:runnin_us/const/dummy.dart';
import 'package:runnin_us/screen/map/google_map.dart';

class WaitingRoomScreen extends StatefulWidget {
  const WaitingRoomScreen({Key? key}) : super(key: key);

  @override
  State<WaitingRoomScreen> createState() => _WaitingRoomScreenState();
}

class _WaitingRoomScreenState extends State<WaitingRoomScreen> {
  var _selectedValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Positioned(

                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => MyExercise(),
                          ),
                        );
                      },
                      child: Text('대기실 생성'),
                    ),
                  ),
                ],
              ),
            )),
        Expanded(
          flex: 7,
          child: ListView.separated(
              itemBuilder: (context, index) {
                return renderWaitingRoom();
              },
              separatorBuilder: (context, index) {
                if (index % 8 == 0 && index != 0) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Text('${index} 광고 노출 배너'),
                  );
                }
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  child: Text('$index'),
                );
              },
              itemCount: 30),
        ),
      ],
    );
  }

  renderWaitingRoom() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
      ),
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Row(
        children: [],
      ),
    );
  }
}
