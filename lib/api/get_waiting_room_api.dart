import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:runnin_us/const/data_dart.dart';
import 'package:runnin_us/const/dummy.dart';

Future<Position> GetWaitingRoomAPI() async {
  currentPosition = await Geolocator.getCurrentPosition();
  print(currentPosition);

  LatLng nowLatLng =
      LatLng(currentPosition!.latitude, currentPosition!.longitude);
  print(nowLatLng.latitude);
  print(nowLatLng.longitude);

  try {
    var dio = await Dio().request(
      'http://runninus-api.befined.com:8000/v1/meet/search',
      data: {
        "point_x": 37.3817369,
        "point_y": 127.1210368,
      },
      options: Options(method: 'POST'),
    );

    waitingRoomList=[...dio.data['results']];
  } catch (e) {
    print(e);
  }

  return Geolocator.getCurrentPosition();
}
