import 'package:dio/dio.dart';
import 'package:runnin_us/const/dummy.dart';

Future<bool?> ExitWaitingRoomApi()async{
  try {
    var dio = await Dio().request(
      'http://runninus-api.befined.com:8000/v1/meet/quit',
      data: {"meet_id": myEnteredRoom['roomId'], "user_id": 15},
      options: Options(method: 'POST'),
    );

    return dio.data['isSuccess'];
  } catch (e) {
    print(e);
    return false;
  }
}