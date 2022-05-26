import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runnin_us/api/check_user_in_waiting_room.dart';
import 'package:runnin_us/api/get_user_info.dart';
import 'package:runnin_us/api/update_user_info.dart';
import 'package:runnin_us/const/dummy.dart';
import 'package:runnin_us/provider/enter_check.dart';
import 'package:runnin_us/screen/main/home_screen.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  // void _get_user_info() async {
  //   try {
  //     User user = await UserApi.instance.me();
  //     print('사용자 정보 요청 성공'
  //         '\n회원 정보: ${user.id}'
  //         '\n회원 이름: ${user.kakaoAccount?.profile?.nickname}');
  //   } catch (e) {
  //     print("사용자 정보 요청 실패 $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: IconButton(
                icon: Image.asset('asset/img/main.png'),
                iconSize: 500,
                onPressed: () async {
                  int? code = await CheckUserInWaitingRoomApi();
                  if (code == 200) {
                    isEntered = true;
                    print(myEnteredRoom['host']);
                    print(myPageList[0]['uid']);

                    if (myEnteredRoom['host'].toString() == myPageList[0]['uid'].toString()) {
                      isHost = true;
                    }
                  }
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (_) => ChangeNotifierProvider(
                              create: (_) => EnterCheck(),
                              child: HomeScreen(),
                            )),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  icon: Image.asset('asset/img/kakao_login.png'),
                  iconSize: 400,
                  onPressed: () async {
                    updateUserInfoApi();
                    // final result = await FlutterWebAuth.authenticate(
                    //     url:
                    //         'http://runninus-api.befined.com:8000/v1/login/kakao',
                    //     callbackUrlScheme: "효재햄 여기서 뭐가 드가야하나용가리");
                    // print("콜백 결과 확인해보기 : {$result}");
                    // //쿼리 리턴값에서 uid만 추출해보기
                    // final uid = Uri.parse(result).queryParameters['uid'];
                    // print("받아온 코드 나와라 얍: {$uid}");
                  }),
            ),
          ],
        ));
  }
}
