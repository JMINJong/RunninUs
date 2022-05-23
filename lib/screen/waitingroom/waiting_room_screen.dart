import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as d;
import 'package:provider/provider.dart';
import 'package:runnin_us/api/enter_waiting_room_api.dart';
import 'package:runnin_us/api/get_waiting_room_api.dart';
import 'package:runnin_us/const/color.dart';
import 'package:runnin_us/const/dummy.dart';
import 'package:runnin_us/provider/enter_check.dart';
import 'package:runnin_us/screen/exercise/exercise_authentication.dart';

import '../../const/data_dart.dart';
import '../main/get_user_info.dart';

const TextStyle ts = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontWeight: FontWeight.w500,
);

class WaitingRoomScreen extends StatefulWidget {
  const WaitingRoomScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WaitingRoomScreen> createState() => _WaitingRoomScreenState();
}

class _WaitingRoomScreenState extends State<WaitingRoomScreen> {
  late EnterCheck _enterCheck;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _enterCheck = Provider.of<EnterCheck>(context);

    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _enterCheck.EnterCreateRoom();
                  },
                  child: Text('대기실 생성'),
                  style: ElevatedButton.styleFrom(
                    primary: MINT_COLOR,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ExerciseAuthentication()));
                  },
                  child: Text('운동 검증'),
                  style: ElevatedButton.styleFrom(
                    primary: MINT_COLOR,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => GetUserInfo()));
                  },
                  child: Text('유저 정보 받아오기'),
                  style: ElevatedButton.styleFrom(
                    primary: MINT_COLOR,
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: FutureBuilder(
              future: GetWaitingRoomAPI(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData == false) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                LatLng nowLatLng =
                    LatLng(snapshot.data.latitude, snapshot.data.longitude);

                print(nowLatLng);
                return RefreshIndicator(
                  onRefresh: () {
                    setState(() {});
                    return GetWaitingRoomAPI();
                  },
                  child: ListView.separated(
                      itemBuilder: (
                        context,
                        index,
                      ) {
                        return renderWaitingRoom(
                          index,
                          nowLatLng,
                        );
                      },
                      separatorBuilder: (context, index) {
                        if (index % 8 == 0 && index != 0) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            child: Text('광고 노출 배너'),
                          );
                        }
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 30,
                          child: Text(''),
                        );
                      },
                      itemCount: waitingRoomList.length),
                );
              }),
        ),
      ],
    );
  }

  renderWaitingRoom(
    int index,
    LatLng data,
  ) {
    final LatLng latlng = LatLng(waitingRoomList[index]['POINT']['y'],
        waitingRoomList[index]['POINT']['x']);
    final CameraPosition cp = CameraPosition(target: latlng, zoom: 17);
    final Marker marker =
        Marker(markerId: MarkerId('marker$index'), position: latlng);
    final double distance = d.Distance().as(
        d.LengthUnit.Kilometer,
        d.LatLng(latlng.latitude, latlng.longitude),
        d.LatLng(data.latitude, data.longitude));
    bool levelTooHigh = false;
    bool isRoomFull = false;

    if (int.parse(waitingRoomList[index]['LEVEL']) >
        int.parse(myPageList[0]['level'])) {
      levelTooHigh = true;
    }

    if (waitingRoomList[index]['MAX_NUM'] ==
        int.parse(waitingRoomList[index]['NOW_NUM'])) {
      isRoomFull = true;
    }

    return GestureDetector(
      onTap: () {
        //async await 으로 구성
        //인덱스 값 서버 전송
        //인덱스 값 받아옴
        //받아온 인덱스로 대기실 구성
        //출력
        // if (waitingRoom[index]['member'].length >=
        //     int.parse(waitingRoom[index]['maxMember']) - 1) {
        //   showDialog(
        //     context: context,
        //     builder: (_) {
        //       return AlertDialog(
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(10.0),
        //         ),
        //         title: Text('입장 실패'),
        //         content: Text('사유 : 정원이 초과되었습니다.'),
        //         actions: [
        //           ElevatedButton(
        //               style: ElevatedButton.styleFrom(primary: PINK_COLOR),
        //               onPressed: () {
        //                 Navigator.of(context).pop();
        //               },
        //               child: Text('확인'))
        //         ],
        //       );
        //     },
        //   );
        // } else if (int.parse(waitingRoom[index]['level']) >
        //     int.parse(myPageList[0]['level'])) {
        //   showDialog(
        //     context: context,
        //     builder: (_) {
        //       return AlertDialog(
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(10.0),
        //         ),
        //         title: Text('입장 실패'),
        //         content: Text('사유 : 운동 레벨이 너무 높습니다.'),
        //         actions: [
        //           ElevatedButton(
        //               style: ElevatedButton.styleFrom(primary: PINK_COLOR),
        //               onPressed: () {
        //                 Navigator.of(context).pop();
        //               },
        //               child: Text('확인'))
        //         ],
        //       );
        //     },
        //   );
        // } else {
        print('입장');
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: Text('대기실 입장'),
              content: Text('입장하시겠습니까?'),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: PINK_COLOR),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('취소')),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: MINT_COLOR),
                    onPressed: () async {
                      print(int.parse(waitingRoomList[index]['UID']));
                      bool? isEnter = await EnterWaitingRoomApi(
                          int.parse(waitingRoomList[index]['UID']));

                      if (isEnter == true) {
                        _enterCheck.Enter();
                        Navigator.of(context).pop();
                      } else {
                        Navigator.of(context).pop();
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              title: Text('입장 실패'),
                              content: Text('사유 : 정원이 가득 찼습니다.'),
                              actions: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: PINK_COLOR),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('확인'))
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text('확인'))
              ],
            );
          },
        );
        // }
      },
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 16,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: Text(
              '${waitingRoomList[index]['NAME']}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: MINT_COLOR.withOpacity(0.7),
              border: Border.all(color: Colors.black, width: 2),
            ),
            height: MediaQuery.of(context).size.width / 4,
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: GoogleMap(
                    onTap: (value) {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height / 2,
                              child: GoogleMap(
                                myLocationButtonEnabled: false,
                                initialCameraPosition: cp,
                                markers: {marker},
                              ),
                            );
                          });
                    },
                    zoomControlsEnabled: false,
                    initialCameraPosition: cp,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 6 / 12 - 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: levelTooHigh
                            ? Text(
                                '운동레벨 : ${waitingRoomList[index]['LEVEL']}',
                                style: ts.copyWith(color: Colors.red),
                              )
                            : Text(
                                '운동레벨 : ${waitingRoomList[index]['LEVEL']}',
                                style: ts,
                              ),
                      ),
                      Text(
                        '운동 시간 : ${waitingRoomList[index]['EX_START_TIME'].split('T')[1].split('.')[0]}~ ${waitingRoomList[index]['EX_END_TIME'].split('T')[1].split('.')[0]}',
                        style: ts.copyWith(fontSize: 16),
                      ),
                      Center(
                        child: Text(
                          '운동 거리 : ${waitingRoomList[index]['EX_DISTANCE']} km',
                          style: ts.copyWith(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 3 / 12 - 16,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                            child: isRoomFull
                                ? Text(
                                    '${waitingRoomList[index]['MAX_NUM']} / ${waitingRoomList[index]['NOW_NUM']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        color: Colors.red),
                                  )
                                : Text(
                                    '${waitingRoomList[index]['NOW_NUM']} / ${waitingRoomList[index]['MAX_NUM']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20),
                                  )),
                        Text('$distance km',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16))
                      ]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
