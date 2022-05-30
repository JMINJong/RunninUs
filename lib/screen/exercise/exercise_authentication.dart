import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as d;
import 'package:runnin_us/const/color.dart';
import 'package:runnin_us/const/dummy.dart';
import 'package:runnin_us/screen/exercise/authentication_result.dart';

class ExerciseAuthentication extends StatefulWidget {
  const ExerciseAuthentication({Key? key}) : super(key: key);

  @override
  _ExerciseAuthenticationState createState() =>
      _ExerciseAuthenticationState();
}

class _ExerciseAuthenticationState
    extends State<ExerciseAuthentication> {
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
  Set<Polyline> polyLineForAuth = {};
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
                  currentPosition = snapshot.data;
                  movePath.clear();
                  polyLineForAuth.clear();
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
                      if (totalLengthForSpeed>=1000) {
                        exerciseAuthentication['totalLength'] =
                            totalLengthForSpeed.toString();
                        exerciseAuthentication['totalTime'] =
                        totalTime.toString().split('.')[0];
                        exerciseAuthentication['averageSpeed'] =
                            nowSpeed.toStringAsFixed(1);


                        if(nowSpeed<8.28){
                          exerciseAuthentication['level']='1';
                        }else if(nowSpeed>=8.28 && nowSpeed < 9.72){
                          exerciseAuthentication['level']='2';
                        }else if(nowSpeed>=9.72 && nowSpeed < 11.88){
                          exerciseAuthentication['level']='3';
                        }else if(nowSpeed>=11.88 && nowSpeed < 14.4){
                          exerciseAuthentication['level']='4';
                        }else if(nowSpeed>=14.4 && nowSpeed < 16.2){
                          exerciseAuthentication['level']='5';
                        }else if(nowSpeed>=16.2 && nowSpeed < 18){
                          exerciseAuthentication['level']='6';
                        }else if(nowSpeed>=18 && nowSpeed < 19.8){
                          exerciseAuthentication['level']='7';
                        }else if(nowSpeed>=19.8 && nowSpeed < 21.6){
                          exerciseAuthentication['level']='8';
                        }else if(nowSpeed>=21.6 && nowSpeed < 23.6){
                          exerciseAuthentication['level']='9';
                        }else if(nowSpeed>=23.6){
                          exerciseAuthentication['level']='10';
                        }






                        Fluttertoast.showToast(
                            msg: "검증 종료! 곧 결과 페이지로 이동합니다.",
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
                                builder: (_) => AuthenticationResult(),
                              ),
                            );
                          },
                        );
                      }

                      totalTime = startTime.difference(endTime);

                      Position po = snapshot.data;
                      LatLng laln = LatLng(po.latitude, po.longitude);
                      movePath.add(laln);
                      polyLineForAuth.add(
                        Polyline(
                            polylineId: PolylineId(snapshot.data.toString()),
                            visible: true,
                            points: movePath,
                            color: Colors.blue),
                      );

                      int hours =
                          int.parse(totalTime.toString().split(':')[0]) * 3600;
                      int minutes =
                          int.parse(totalTime.toString().split(':')[1]) * 60;
                      int seconds = int.parse(
                          totalTime.toString().split(':')[2].split('.')[0]);

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
                                myLocationButtonEnabled: false,
                                initialCameraPosition:
                                    CameraPosition(target: laln, zoom: 17),
                                markers: {
                                  Marker(
                                      markerId: MarkerId('m'), position: laln)
                                },
                                onMapCreated: (controller) {
                                  mapController = controller;
                                },
                                polylines: polyLineForAuth,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                          MediaQuery.of(context).size.height /
                                              12,
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
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    title: Text('검층 취소'),
                                                    content:
                                                        Text('운동 검증을 취소하시겠습니까?'),
                                                    actions: [
                                                      ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  primary:
                                                                      PINK_COLOR),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text('취소')),
                                                      ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  primary:
                                                                      MINT_COLOR),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            Navigator.of(
                                                                    context)
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
                                            child: Text('검증 취소'),
                                          ),
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                      ),
                                    ),
                                  ),
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
