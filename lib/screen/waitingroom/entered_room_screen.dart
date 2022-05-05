import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:runnin_us/const/color.dart';
import 'package:runnin_us/const/dummy.dart';
import 'package:runnin_us/googlemap/on_runnin.dart';
import 'package:runnin_us/provider/enter_check.dart';

//대기실 내부 화면
//방장 권한 확인

class EnteredWaitingRoom extends StatefulWidget {
  const EnteredWaitingRoom({Key? key}) : super(key: key);

  @override
  State<EnteredWaitingRoom> createState() => _EnteredWaitingRoomState();
}

class _EnteredWaitingRoomState extends State<EnteredWaitingRoom> {
  late EnterCheck _enterCheck;

  @override
  Widget build(BuildContext context) {
    List members = enteredWaitingRoom['member'].values.toList();
    _enterCheck = Provider.of<EnterCheck>(context);
    LatLng initialLatLng = LatLng(double.parse(enteredWaitingRoom['latitude']),
        double.parse(enteredWaitingRoom['longitude']));
    CameraPosition initialCameraPosition =
        CameraPosition(target: initialLatLng, zoom: 15);
    Marker initialMarker = Marker(
      markerId: MarkerId('WaitingRoomMarker'),
      position: initialLatLng,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
              border: Border.all(color: MINT_COLOR, width: 3),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${enteredWaitingRoom['host']} 님의 대기실',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: GoogleMap(
              initialCameraPosition: initialCameraPosition,
              markers: {initialMarker},
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '${enteredWaitingRoom['startTime']} ~ ${enteredWaitingRoom['endTime']}',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
            ),
            Text(
              ' 난이도 : ${enteredWaitingRoom['level']}',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Column(
          children: members.map((e) {
            return SizedBox(
                height: MediaQuery.of(context).size.height / 12,
                child: Center(
                  child: Text(
                    '참여자 : $e',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                  ),
                ));
          }).toList(),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: PINK_COLOR),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        title: Text('대기실 퇴장'),
                        content: Text('퇴장하시겠습니까?'),
                        actions: [
                          ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: PINK_COLOR),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('취소')),
                          ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: MINT_COLOR),
                              onPressed: () {
                                _enterCheck.Exit();
                                Navigator.of(context).pop();
                              },
                              child: Text('확인'))
                        ],
                      );
                    },
                  );
                },
                child: Text('나가기'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: MINT_COLOR),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        title: Text('운동 시작'),
                        content: Text('운동을 시작하시겠습니까?'),
                        actions: [
                          ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: PINK_COLOR),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('취소')),
                          ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: MINT_COLOR),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (_) => OnRunningScreen()));
                              },
                              child: Text('확인'))
                        ],
                      );
                    },
                  );
                },
                child: Text('시작하기'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
