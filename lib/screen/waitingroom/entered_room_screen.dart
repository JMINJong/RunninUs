import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:runnin_us/const/color.dart';
import 'package:runnin_us/const/dummy.dart';
import 'package:runnin_us/screen/exercise/on_runnin.dart';
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
    List members = myEnteredRoom['member'];
    int memberCount = int.parse(myEnteredRoom['maxMember']);
    _enterCheck = Provider.of<EnterCheck>(context);
    LatLng initialLatLng = LatLng(double.parse(myEnteredRoom['latitude']),
        double.parse(myEnteredRoom['longitude']));
    CameraPosition initialCameraPosition =
        CameraPosition(target: initialLatLng, zoom: 15);
    Marker initialMarker = Marker(
      markerId: MarkerId('WaitingRoomMarker'),
      position: initialLatLng,
    );
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - kToolbarHeight - 170,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: MINT_COLOR, width: 3),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${myEnteredRoom['roomName']}',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height:
                        MediaQuery.of(context).size.height / 2 - kToolbarHeight,
                    child: GoogleMap(
                      onTap: (index) {
                        setState(() {});
                      },
                      initialCameraPosition: initialCameraPosition,
                      markers: {initialMarker},
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    '운동 시간 : ${myEnteredRoom['startTime']} ~  ${myEnteredRoom['endTime']}',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        ' 난이도 : ${myEnteredRoom['level']}',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        ' 주행 거리 : ${myEnteredRoom['runningLength']} km',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    '호스트 : ${myEnteredRoom['host']}',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Column(
                    children: members.map(
                      (e) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height / 24,
                          child: Center(
                            child: Text(
                              '참여자 : $e',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w500),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            ),
          ),
          Row(
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
                                myEnteredRoom['member'].clear();

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
                onPressed: _enterCheck.isHost
                    ? () {
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
                                    style: ElevatedButton.styleFrom(
                                        primary: PINK_COLOR),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('취소')),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: MINT_COLOR),
                                    onPressed: () {
                                      _enterCheck.StartRoom();
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  OnRunningScreen()));
                                    },
                                    child: Text('확인'))
                              ],
                            );
                          },
                        );
                      }
                    : null,
                child: Text('시작하기'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
