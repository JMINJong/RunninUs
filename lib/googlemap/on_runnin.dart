import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as d;

//운동 중 화면

List<LatLng> movePath = [];
List<double> count = [0, 0];
Set<Polyline> polyline = {};

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
  bool kilo = false;
  bool camera=false;
  late GoogleMapController mapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                movePath.clear();
                polyline.clear();
                final startTime = DateTime.now();
                movePathIndex = 0;

                return StreamBuilder<Position>(
                  stream: Geolocator.getPositionStream(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData == false) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    endTime = DateTime.now();

                    Duration totalTime = startTime.difference(endTime);
                    print('현재 위치 : ${snapshot.data}');
                    print('현재 달린 거리 :${kiloMeter}km ${totalLength} m');
                    print('시작 시간 : $startTime');
                    print('현재 시간 : $endTime');
                    print('달린 시간 : $totalTime');
                    print('총 걸린 시간 : $totalHour');
                    print('현재 인덱스 값 : $movePathIndex');

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
                    if(camera==true){
                      mapController.animateCamera(CameraUpdate.newLatLng(laln));
                    }

                    camera=true;

                    return Column(
                      children: [
                        Expanded(
                          child: GoogleMap(

                            initialCameraPosition:
                                CameraPosition(target: laln, zoom: 17),
                            markers: {
                              Marker(markerId: MarkerId('m'), position: laln)
                            },
                            onMapCreated: (controller){
                              mapController=controller;
                            },
                            polylines: polyline,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              kilo
                                  ? Text(
                                      '현재 달린 거리 :${kiloMeter} km ${totalLength.toString().split('.')[0]} m')
                                  : Text(
                                      '현재 달린 거리 :${totalLength.toString().split('.')[0]} m'),
                              Text(
                                  '달린 시간 : ${totalTime.toString().split('.')[0]}'),
                              Text(
                                  '현재 속력 : ${nowSpeed.toStringAsFixed(1)} k/m'),

                              // Countup(
                              //   begin: count[timeCountEnd],
                              //   end: count[timeCountStart],
                              //   duration: Duration(seconds: 2),
                              // ),
                            ],
                          ),
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }


}
