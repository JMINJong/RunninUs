import 'package:dio/dio.dart';
import 'package:runnin_us/const/data_dart.dart';
import 'package:runnin_us/const/dummy.dart';
import 'api_generator.dart';

Future getUserInfoApi() async {
  try {
    var dio = await Dio().request(
      getApi(API.GET_USER_INFO),
      data: {
        "user_id": myPageList[0]['uid']
      },
      options: Options(method: 'POST'),
    );
        recievedUserInfo=[...dio.data['results']];
        print(recievedUserInfo);
  } catch (e) {
    print(e);
  }

  return recievedUserInfo;
}
