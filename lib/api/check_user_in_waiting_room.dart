import 'package:dio/dio.dart';
import 'package:runnin_us/api/get_user_nick.dart';
import '../const/dummy.dart';
import '../socket/socket_io.dart';

Future<int?> CheckUserInWaitingRoomApi() async {
  try {
    var dio = await Dio().request(
      "http://runninus-api.befined.com:8000/v1/user/check",
      data: {"user_id": myPageList[0]['uid']},
      options: Options(method: 'POST'),
    );
    if (dio.data['code'] == 200) {
      String? name =
          await GetUserNick(int.parse(dio.data['results'][0]['HOST']));
      myEnteredRoom['roomId'] = int.parse(dio.data['results'][0]['UID']);
      myEnteredRoom['roomName'] = dio.data['results'][0]['NAME'].toString();
      myEnteredRoom['host'] = name;
      myEnteredRoom['latitude'] =
          dio.data['results'][0]['POINT']['y'].toString();
      myEnteredRoom['longitude'] =
          dio.data['results'][0]['POINT']['x'].toString();
      myEnteredRoom['runningLength'] =
          dio.data['results'][0]['EX_DISTANCE'].toString();
      myEnteredRoom['startTime'] =
          dio.data['results'][0]['EX_START_TIME'].split('.')[0].split('T')[1];
      myEnteredRoom['endTime'] =
          dio.data['results'][0]['EX_END_TIME'].split('.')[0].split('T')[1];
      myEnteredRoom['level'] = dio.data['results'][0]['LEVEL'].toString();
      myEnteredRoom['maxMember'] = dio.data['results'][0]['MAX_NUM'].toString();
      dio.data['results'][0]['NOW_USER_INFO'].map((e){
        myEnteredRoom['member'].add(e['NICK']);
      }).toList();
      socketRoomEnter(
          myPageList[0]['uid'], int.parse(dio.data['results'][0]['UID']), true);
    }
    // print(myEnteredRoom);


    return dio.data['code'];
  } catch (e) {
    print(e);
  }
}
