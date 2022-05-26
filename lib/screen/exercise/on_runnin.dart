import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as d;
import 'package:runnin_us/const/color.dart';
import 'package:runnin_us/const/dummy.dart';
import 'package:runnin_us/screen/exercise/exercise_result.dart';
import 'package:runnin_us/socket/socket_io.dart';

//운동 중 화면




class OnRunningScreen extends StatefulWidget {
  const OnRunningScreen({Key? key}) : super(key: key);

  @override
  _OnRunningScreenState createState() => _OnRunningScreenState();
}

class _OnRunningScreenState extends State<OnRunningScreen> {
  int kiloMeter = 0;
  int movePathIndex = 0;
  int timeCountIndex = 0;
  int timeCountStart = 0;
  int timeCountEnd = 1;
  int totalHour = 0;
  double totalLength = 0;
  double totalLengthForSpeed = 0;
  double nowSpeed = 0.00;
  DateTime endTime = DateTime.now();
  late Duration totalTime;
  bool kilo = false;
  bool camera = false;
  List<LatLng> movePath = [];
  List<double> count = [0, 0];
  late GoogleMapController mapController;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: Geolocator.getCurrentPosition(),
                builder:
                    (BuildContext context, AsyncSnapshot<Position> snapshot) {
                  if (snapshot.hasData == false) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  currentPosition=snapshot.data;
                  movePath.clear();
                  polyline.clear();
                  final startTime = DateTime.now();
                  movePathIndex = 0;

                  return StreamBuilder<Position>(
                    stream: Geolocator.getPositionStream(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData == false) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      endTime = DateTime.now();
                      // print(myEnteredRoom['endTime']);
                      // print(endTime);
                      // print(
                      //     '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}');
                      if (myEnteredRoom['endTime'] ==
                          '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}') {
                        resultExercise['totalLength'] =
                            totalLengthForSpeed.toString();
                        resultExercise['totalTime'] =
                            totalTime.toString().split('.')[0];
                        resultExercise['averageSpeed'] =
                            nowSpeed.toStringAsFixed(1);
                        resultExercise['kcal'] =
                            (totalHour * 0.1225).toStringAsFixed(2);
                        Fluttertoast.showToast(
                            msg: "운동 종료! 곧 결과 페이지로 이동합니다.",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 20.0);
                        Future.delayed(Duration(seconds: 3)).then(
                          (value) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => ExerciseResult(),
                              ),
                            );
                          },
                        );
                      }

                      totalTime = startTime.difference(endTime);
                      // print('현재 위치 : ${snapshot.data}');
                      // print('현재 달린 거리 :${kiloMeter}km ${totalLength} m');
                      // print('시작 시간 : $startTime');
                      // print('현재 시간 : $endTime');
                      // print('달린 시간 : $totalTime');
                      // print('총 걸린 시간 : $totalHour');
                      // print('현재 인덱스 값 : $movePathIndex');

                      Position po = snapshot.data;
                      LatLng laln = LatLng(po.latitude, po.longitude);
                      movePath.add(laln);
                      polyline.add(
                        Polyline(
                            polylineId: PolylineId(snapshot.data.toString()),
                            visible: true,
                            points: movePath,
                            color: Colors.blue),
                      );
                      // if(timeCountIndex==0){
                      //   timeCountIndex++;
                      //   timeCountStart=1;
                      //   timeCountEnd=0;
                      // }else{
                      //   timeCountIndex--;
                      //   timeCountStart=0;
                      //   timeCountEnd=1;
                      // }
                      // count 위젯 사용해서 숫자 올리기 -> 맘처럼 잘 안됨;
                      // count[timeCountIndex]=double.parse(totalTime.inSeconds.toString())*-1;
                      // print(timeCountIndex);
                      // print(count);
                      int hours =
                          int.parse(totalTime.toString().split(':')[0]) * 3600;
                      int minutes =
                          int.parse(totalTime.toString().split(':')[1]) * 60;
                      int seconds = int.parse(
                          totalTime.toString().split(':')[2].split('.')[0]);
                      // print(hours);
                      // print(minutes);
                      // print(seconds);
                      totalHour = hours + minutes + seconds;

                      if (movePathIndex >= 1) {
                        totalLength += d.Distance().as(
                            d.LengthUnit.Meter,
                            d.LatLng(movePath[movePathIndex].latitude,
                                movePath[movePathIndex].longitude),
                            d.LatLng(movePath[movePathIndex - 1].latitude,
                                movePath[movePathIndex - 1].longitude));

                        totalLengthForSpeed += d.Distance().as(
                            d.LengthUnit.Meter,
                            d.LatLng(movePath[movePathIndex].latitude,
                                movePath[movePathIndex].longitude),
                            d.LatLng(movePath[movePathIndex - 1].latitude,
                                movePath[movePathIndex - 1].longitude));

                        if (totalLength >= 1000) {
                          kilo = true;
                          kiloMeter++;
                          totalLength -= 1000;
                        }
                      }
                      nowSpeed = totalLengthForSpeed / totalHour * 3.6;

                      movePathIndex++;
                      if (camera == true) {
                        mapController
                            .animateCamera(CameraUpdate.newLatLng(laln));
                      }

                      camera = true;

                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: GoogleMap(
                                initialCameraPosition:
                                    CameraPosition(target: laln, zoom: 17),
                                markers: {
                                  Marker(markerId: MarkerId('m'), position: laln)
                                },
                                onMapCreated: (controller) {
                                  mapController = controller;
                                },
                                polylines: polyline,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  kilo
                                      ? renderContainer(
                                          '현재 달린 거리 :${kiloMeter} km ${totalLength.toString().split('.')[0]} m')
                                      : renderContainer(
                                          '현재 달린 거리 :${totalLength.toString().split('.')[0]} m'),
                                  renderContainer(
                                      '달린 시간 : ${totalTime.toString().split('.')[0]}'),
                                  renderContainer(
                                      '현재 속력 : ${nowSpeed.toStringAsFixed(1)} k/m'),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height / 12,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: MINT_COLOR, width: 2),
                                      ),
                                      child: Row(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (_) {
                                                  return AlertDialog(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    title: Text('운동 취소'),
                                                    content: Text('정말로 나가시겠습니까?'),
                                                    actions: [
                                                      ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  primary:
                                                                      PINK_COLOR),
                                                          onPressed: () {
                                                            Navigator.of(context)
                                                                .pop();
                                                          },
                                                          child: Text('취소')),
                                                      ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  primary:
                                                                      MINT_COLOR),
                                                          onPressed: () {
                                                            Navigator.of(context)
                                                                .pop();
                                                            Navigator.of(context)
                                                                .pop();
                                                          },
                                                          child: Text('확인'))
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: PINK_COLOR,
                                              minimumSize: Size(75, 37),
                                            ),
                                            child: Text('운동 취소'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (_) {
                                                  return AlertDialog(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    title: Text('운동 종료'),
                                                    content:
                                                        Text('정말로 종료하시겠습니까?'),
                                                    actions: [
                                                      ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  primary:
                                                                      PINK_COLOR),
                                                          onPressed: () {
                                                            Navigator.of(context)
                                                                .pop();
                                                          },
                                                          child: Text('취소')),
                                                      ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  primary:
                                                                      MINT_COLOR),
                                                          onPressed: () {
                                                            socketRoomEnd();
                                                            resultExercise[
                                                                    'totalLength'] =
                                                                totalLengthForSpeed
                                                                    .toString();
                                                            resultExercise[
                                                                    'totalTime'] =
                                                                totalTime
                                                                    .toString()
                                                                    .split(
                                                                        '.')[0];
                                                            resultExercise[
                                                                    'averageSpeed'] =
                                                                nowSpeed
                                                                    .toStringAsFixed(
                                                                        1);
                                                            resultExercise[
                                                                    'kcal'] =
                                                                (totalHour *
                                                                        0.1225)
                                                                    .toStringAsFixed(
                                                                        2);
                                                            Navigator.of(context)
                                                                .pop();
                                                            Navigator.of(context)
                                                                .pushReplacement(
                                                              MaterialPageRoute(
                                                                builder: (_) =>
                                                                    ExerciseResult(),
                                                              ),
                                                            );
                                                          },
                                                          child: Text('확인'))
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: MINT_COLOR,
                                            ),
                                            child: Text('운동 종료'),
                                          ),
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                      ),
                                    ),
                                  ),

                                  // Countup(
                                  //   begin: count[timeCountEnd],
                                  //   end: count[timeCountStart],
                                  //   duration: Duration(seconds: 2),
                                  // ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget renderContainer(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 12,
        decoration: BoxDecoration(
          border: Border.all(color: MINT_COLOR, width: 2),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
