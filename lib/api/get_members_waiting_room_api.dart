import 'package:dio/dio.dart';

import '../const/dummy.dart';

Future<void>GetMembersWaitingRoom()async{


  try {
    var dio = await Dio().request(
      "http://runninus-api.befined.com:8000/v1/meet/user",
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