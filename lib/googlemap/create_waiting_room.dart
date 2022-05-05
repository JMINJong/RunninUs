import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:runnin_us/const/color.dart';

import '../provider/enter_check.dart';

//대기실 생성 화면

List selectedButtonLevel = [1, 2, 3, 4, 5];
List selectedButtonLevel2 = [6, 7, 8, 9, 10];
List maxNumber = [2, 3, 4, 5, 6];

class CreateWaitingRoom extends StatefulWidget {
  const CreateWaitingRoom({Key? key}) : super(key: key);

  @override
  _CreateWaitingRoomState createState() => _CreateWaitingRoomState();
}

class _CreateWaitingRoomState extends State<CreateWaitingRoom> {
  static LatLng defaultLatLng = LatLng(37.435308, 127.138625);
  late LatLng selectedLatLng;
  String selectedDate = '';
  String selectedStartTime = '';
  String selectedEndTime = '';
  String selectedLevel = '';
  String maxMemberCount = '';
  int selectedButtonIndex = 0;
  int selectedMaxNumberIndex = 0;
  int today = 200;
  int startHour = 200;
  int startMinute = 200;
  String dateButton = '날짜';
  String startButton = '시작 시간';
  String endButton = '종료 시간';
  static CameraPosition initialPosition =
      CameraPosition(target: defaultLatLng, zoom: 15);
  static Circle defaultCircle = Circle(
    circleId: CircleId('circle'),
    radius: 100,
    center: defaultLatLng,
    fillColor: Colors.grey.withOpacity(0.3),
    strokeWidth: 1,
  );
  static Marker defaultMarker =
      Marker(markerId: MarkerId('marker'), position: defaultLatLng);
  late GoogleMapController _controller;
  late EnterCheck _enterCheck;

  @override
  Widget build(BuildContext context) {
    _enterCheck = Provider.of<EnterCheck>(context);
    return renderGmap();
  }

  Widget renderGmap() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 3 - 20,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: MINT_COLOR,
                ),
                onPressed: () {
                  Future<DateTime?> sD = showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day + 7,
                    ),
                  );
                  sD.then(
                    (value) => setState(
                      () {
                        if (value == null) {
                          dateButton = '날짜';
                        } else {
                          dateButton = value.toString().split(' ')[0];
                          selectedDate = value.toString();
                          today = value.day;
                        }
                      },
                    ),
                  );
                },
                child: Text(dateButton),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3 - 20,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: MINT_COLOR,
                ),
                onPressed: () {
                  Future<TimeOfDay?> sT = showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  sT.then(
                    (value) {
                      if (today == 200) {
                        showToast('날짜를 먼저 선택해주세요.');
                        return false;
                      }

                      if (today == DateTime.now().day) {
                        if (value!.hour < DateTime.now().hour) {
                          showToast('시작 시간은 현재 시간보다 빠를 수 없습니다.');
                          return false;
                        } else if (value.hour == DateTime.now().hour) {
                          if (value.minute <= DateTime.now().minute) {
                            showToast('시작 시간은 현재 시간보다 같거나 빠를 수 없습니다.');
                            return false;
                          } else {
                            if (((60 - value.minute) -
                                        (60 - DateTime.now().minute))
                                    .abs() <
                                15) {
                              showToast('시작 시간은 현재 시간보다 최소 15분 뒤여야 합니다.');
                              return false;
                            }
                          }
                        }
                      }
                      if (value!.hour == DateTime.now().hour + 1) {
                        if (DateTime.now().minute >= 45) {
                          int diff = 60 - DateTime.now().minute;
                          if (value.minute < (15 - diff)) {
                            showToast('시작 시간은 현재 시간보다 최소 15분 뒤여야 합니다.');
                            return false;
                          }
                        }
                      }

                      setState(
                        () {
                          startButton = '${value.hour}:${value.minute}';
                          selectedStartTime = '${value.hour}:${value.minute}';

                          endButton = '종료시간';
                          selectedEndTime = '';
                        },
                      );
                      startHour = value.hour;
                      startMinute = value.minute;
                    },
                  );
                },
                child: Text(startButton),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3 - 20,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: MINT_COLOR,
                ),
                onPressed: () {
                  Future<TimeOfDay?> eT = showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  eT.then(
                    (value) {
                      if (startHour == 200 || startMinute == 200) {
                        showToast('날짜와 시작 시간을 먼저 선택해주세요.');
                        return false;
                      }
                      if (value!.hour < startHour) {
                        showToast('종료 시간은 시작 시간보다 빠를 수 없습니다.');
                        return false;
                      } else if (value.hour == startHour) {
                        if (value.minute < startMinute + 15) {
                          showToast('종료 시간은 시작 시간보다 최소 15분 뒤여야 합니다.');
                          return false;
                        }
                      }

                      if (value.hour == startHour + 1) {
                        if (startMinute >= 45) {
                          int diff = 60 - startMinute;
                          if (value.minute < (15 - diff)) {
                            showToast('종료 시간은 시작 시간보다 최소 15분 뒤여야 합니다.');
                            return false;
                          }
                        }
                      }

                      setState(
                        () {
                          endButton = '${value.hour}:${value.minute}';
                          selectedEndTime = '${value.hour}:${value.minute}';
                        },
                      );
                    },
                  );
                },
                child: Text(endButton),
              ),
            ),
          ],
        ),
        Expanded(
          flex: 1,
          child: FutureBuilder(
            future: Geolocator.getCurrentPosition(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData == false) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              Position position = snapshot.data;
              defaultLatLng = LatLng(position.latitude, position.longitude);
              initialPosition = CameraPosition(target: defaultLatLng, zoom: 15);
              return GoogleMap(
                onMapCreated: (controller) {
                  selectedLatLng = defaultLatLng;
                  setState(() {
                    _controller = controller;
                  });
                },
                initialCameraPosition: initialPosition,
                circles: {defaultCircle},
                markers: {defaultMarker},
                onTap: (LatLng index) {
                  setState(() {
                    selectedLatLng = index;
                    _controller.animateCamera(CameraUpdate.newLatLng(index));
                    defaultMarker =
                        Marker(markerId: MarkerId('marker1'), position: index);
                    defaultCircle = Circle(
                      circleId: CircleId('circle1'),
                      radius: 100,
                      center: index,
                      fillColor: Colors.grey.withOpacity(0.3),
                      strokeWidth: 1,
                    );
                  });
                },
              );
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: selectedButtonLevel.map(
                    (e) {
                      bool isChecked = false;
                      if (selectedButtonIndex == e) {
                        isChecked = true;
                      }
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: isChecked ? PINK_COLOR : MINT_COLOR),
                        onPressed: () {
                          setState(() {
                            selectedButtonIndex = e;
                            selectedLevel = e.toString();
                          });
                        },
                        child: Text('level $e'),
                      );
                    },
                  ).toList()),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: selectedButtonLevel2.map(
                    (e) {
                      bool isChecked = false;
                      if (selectedButtonIndex == e) {
                        isChecked = true;
                      }
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: isChecked ? PINK_COLOR : MINT_COLOR),
                        onPressed: () {
                          setState(() {
                            selectedButtonIndex = e;
                            selectedLevel = e.toString();
                          });
                        },
                        child: Text('level $e'),
                      );
                    },
                  ).toList()),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: maxNumber.map(
                    (e) {
                      bool isChecked = false;
                      if (selectedMaxNumberIndex == e) {
                        isChecked = true;
                      }
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: isChecked ? PINK_COLOR : MINT_COLOR),
                        onPressed: () {
                          setState(() {
                            selectedMaxNumberIndex = e;
                            maxMemberCount = e.toString();
                          });
                        },
                        child: Text('정원 $e'),
                      );
                    },
                  ).toList()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _enterCheck.CancelCreateRoom();
                      },
                      style: ElevatedButton.styleFrom(primary: PINK_COLOR),
                      child: Text('생성 취소'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedEndTime == '' ||
                            selectedStartTime == '' ||
                            selectedDate == '') {
                          showToast('날짜와 시작 시간, 종료 시간을 선택해 주세요.');
                        } else {
                          print(selectedLatLng.latitude);
                          print(selectedLatLng.longitude);
                          print(selectedDate.split(' ')[0]);
                          print(selectedStartTime);
                          print(selectedEndTime);
                          print(selectedLevel);
                          print(maxMemberCount);
                          _enterCheck.CreateRoom();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: MINT_COLOR,
                      ),
                      child: Text('방 생성'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  showToast(String index) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('설정 실패'),
          content: Text(
            index,
            textAlign: TextAlign.center,
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: PINK_COLOR),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('확인'))
          ],
        );
      },
    );
  }
}
