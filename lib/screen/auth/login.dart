import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runnin_us/provider/enter_check.dart';
import 'package:runnin_us/screen/main/home_screen.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

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
                onPressed: () {
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

                  }
              ),
            ),
          ],
        ));
  }
}
