import 'package:dio/dio.dart';
import 'api_generator.dart';
import '../const/dummy.dart';

Future<void>GetMembersWaitingRoom()async{


  try {
    var dio = await Dio().request(
      getApi(API.GET_MEMBERS_MEETING),
      data: {
        "meet_id": myEnteredRoom['roomId'],
      },
      options: Options(method: 'POST'),
    );

    print(dio.data['results']);
    myEnteredRoom['member']=[...(dio.data['results'])];
    print(myEnteredRoom['member']);


  } catch (e) {
    print(e);

  }

}