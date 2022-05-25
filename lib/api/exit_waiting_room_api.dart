import 'package:dio/dio.dart';
import 'package:runnin_us/const/dummy.dart';
import 'api_generator.dart';

Future<bool?> ExitWaitingRoomApi()async{
  try {
    var dio = await Dio().request(
      getApi(API.QUIT_MEETING),
      data: {"meet_id": myEnteredRoom['roomId'], "user_id": 15},
      options: Options(method: 'POST'),
    );

    return dio.data['isSuccess'];
  } catch (e) {
    print(e);
    return false;
  }
}