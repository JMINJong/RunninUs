import 'package:dio/dio.dart';
import 'api_generator.dart';

Future<String?> GetUserNick(int uid) async {
  try {
    var dio = await Dio().request(
      getApi(API.GET_USER_NICK),
      data: {"user_id": uid},
      options: Options(method: 'POST'),
    );
    print(dio.data['results']['NICK']);

    return dio.data['results']['NICK'];
  } catch (e) {
    print(e);
  }
}
