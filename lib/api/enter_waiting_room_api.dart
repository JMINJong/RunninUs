import 'package:dio/dio.dart';
import 'package:runnin_us/api/get_user_nick.dart';
import 'package:runnin_us/const/dummy.dart';
import 'package:runnin_us/socket/socket_io.dart';
import '../provider/enter_check.dart';
import 'api_generator.dart';

Future<bool?> EnterWaitingRoomApi(int roomId) async {



  try {
    var dio = await Dio().request(
      getApi(API.JOIN_MEETING),
      data: {"meet_id": roomId, "user_id": myPageList[0]['uid']},
      options: Options(method: 'POST'),
    );

    String? name=await GetUserNick(int.parse(dio.data['results'][0]['HOST']));
    myEnteredRoom['roomId']=roomId;
    myEnteredRoom['roomName'] = dio.data['results'][0]['NAME'].toString();
    myEnteredRoom['host'] = name;
    myEnteredRoom['latitude'] = dio.data['results'][0]['POINT']['y'].toString();
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
    print(myEnteredRoom);

    socketRoomEnter(myPageList[0]['uid'], roomId,false);
    isHost=false;

    return dio.data['isSuccess'];
  } catch (e) {
    print(e);
    return false;
  }
}
