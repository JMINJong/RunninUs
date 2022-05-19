import 'package:dio/dio.dart';

Future<bool?> CreateWaitingRoomApi(
  String name,
  int host,
  double x,
  double y,
  int max_num,
  int length,
  String date,
  String start_Time,
  String end_Time,
  int level,
) async {
  String exDate = date.split('-')[0] +
      ':' +
      date.split('-')[1] +
      ':' +
      date.split('-')[2].split(' ')[0];

  String exStart = exDate + ' ' + start_Time + ':00';
  String exEnd = exDate + ' ' + end_Time + ':00';

  try {
    var dio = await Dio().request(
      'http://runninus-api.befined.com:8000/v1/meet/create',
      data: {
        "name": name,
        "host": host,
        "point_x": x,
        "point_y": y,
        "max_num": max_num,
        "ex_distance": length,
        "ex_start_time": exStart,
        "ex_end_time": exEnd,
        "level": level
      },
      options: Options(method: 'POST'),
    );

    return dio.data['isSuccess'];
  } catch (e) {
    print(e);
  }
}
