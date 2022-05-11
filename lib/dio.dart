import 'package:dio/dio.dart';

String client_id = "ox29nflr9NzfFHM412Px";
String client_secret = "DZXRvxF_Jy";

getHttp(String text) async {
  String url =
      "https://openapi.naver.com/v1/search/news.json?query=" + text;
  try {
    var response = await Dio().get(
      url,
      options: Options(
        headers: {
          "X-Naver-Client-Id": client_id,
          "X-Naver-Client-Secret": client_secret
        },
      ),
    );


      return response.data['items'];


  } catch (e) {
    print(e);
  }
}
