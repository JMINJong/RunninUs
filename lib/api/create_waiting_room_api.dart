import 'package:dio/dio.dart';
import 'package:runnin_us/const/dummy.dart';
import 'api_generator.dart';

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
      getApi(API.CREATE_MEETING),
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
    print(dio.data['UID']);
    myEnteredRoom['roomId'] = dio.data['UID'];
    print(myEnteredRoom['roomId']);
    return dio.data['isSuccess'];
  } catch (e) {
    print(e);
  }
}
