import 'package:dio/dio.dart';
import 'package:runnin_us/const/dummy.dart';
import 'api_generator.dart';

Future<void> getUserInfoApi(int id) async {
  try {
    var dio = await Dio().request(
      getApi(API.GET_USER_INFO),
      data: {"user_id": id},
      options: Options(method: 'POST'),
    );

    print(dio.data['results']);

     myPageList[0]['name']=dio.data['results'][0]['NICK'];
     myPageList[0]['age']=dio.data['results'][0]['AGE'].toString();
     myPageList[0]['location']=dio.data['results'][0]['TEXT_ADDRESS'].toString();
     myPageList[0]['level']=dio.data['results'][0]['POWER'].toString();
     myPageList[0]['score']=dio.data['results'][0]['MANNER_POINT'].toString();
     //myPageList[0]['name']=dio.data['results'][0]['DISTANCE'].toString();
     myPageList[0]['point']=dio.data['results'][0]['POINT'].toString();


    // dio.data['results'][0]["user_nick"];

    // recievedUserInfo=[...dio.data['results']];
    // print(recievedUserInfo);
  } catch (e) {
    print(e);
  }

  // return recievedUserInfo;
}
