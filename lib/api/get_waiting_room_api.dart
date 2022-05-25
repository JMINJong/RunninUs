import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:runnin_us/const/data_dart.dart';
import 'package:runnin_us/const/dummy.dart';
import 'api_generator.dart';

Future<Position> GetWaitingRoomAPI() async {
  currentPosition = await Geolocator.getCurrentPosition();
  print(currentPosition);

  LatLng nowLatLng = LatLng(currentPosition!.latitude, currentPosition!.longitude);
  print(nowLatLng.latitude);
  print(nowLatLng.longitude);

  try {
    var dio = await Dio().request(
      getApi(API.SEARCH_MEETING),
      data: {
        "point_x": nowLatLng.latitude,
        "point_y": nowLatLng.longitude,
      },
      options: Options(method: 'POST'),
    );

    waitingRoomList=[...dio.data['results']];
  } catch (e) {
    print(e);
  }

  return Geolocator.getCurrentPosition();
}
