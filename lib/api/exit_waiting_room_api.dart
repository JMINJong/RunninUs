import 'package:dio/dio.dart';
import 'package:runnin_us/const/dummy.dart';
import 'package:runnin_us/socket/socket_io.dart';
import 'api_generator.dart';

Future<bool?> ExitWaitingRoomApi() async {
  print(myEnteredRoom['roomId']);
  print(myPageList[0]['uid']);

  try {
    var dio = await Dio().request(
      "${getApi(API.QUIT_MEETING)}",
      data: {
        "user_id": myPageList[0]['uid'],
        "meet_id": myEnteredRoom['roomId'],
      },
      options: Options(method: 'POST'),
    );

    socketRoomExit();

    StreamSocket().dispose();

    return dio.data['isSuccess'];
  } catch (e) {
    print(e);
    return false;
  }
}
