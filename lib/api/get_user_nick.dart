import 'package:dio/dio.dart';

Future<String?> GetUserNick(int uid) async {
  try {
    var dio = await Dio().request(
      "http://runninus-api.befined.com:8000/v1/user/nick",
      data: {"user_id": uid},
      options: Options(method: 'POST'),
    );
    print(dio.data['results']['NICK']);

    return dio.data['results']['NICK'];
  } catch (e) {
    print(e);
  }
}
