import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runnin_us/provider/enter_check.dart';
import 'package:runnin_us/screen/main/home_screen.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

void main(){
  KakaoSdk.init(nativeAppKey: '58b636141acc87e8a31b06d844add97d');
}


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  void _get_user_info() async {
    try {
      User user = await UserApi.instance.me();
      print('사용자 정보 요청 성공'
            '\n회원 정보: ${user.id}'
            '\n회원 이름: ${user.kakaoAccount?.profile?.nickname}');
    } catch (e) {
      print("사용자 정보 요청 실패 $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(flex: 2, child: Image.asset('asset/img/main.png')),
            Expanded(
              flex: 1,
              child: IconButton(
                icon: Image.asset('asset/img/kakao_login.png'),
                iconSize: 400,
                onPressed: () async {
                  if (await isKakaoTalkInstalled()) {
                    try {
                      //loginWithKakaoTalk : 카카오톡으로 로그인
                      await UserApi.instance.loginWithKakaoTalk();
                      print('카카오톡으로 로그인 성공');
                      _get_user_info();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (_) => ChangeNotifierProvider(
                            create: (_) => EnterCheck(),
                            child: HomeScreen(),
                          )));
                    } catch (error) {
                      print('카카오톡으로 로그인 실패 $error');

                      // 카톡에 로그인되어있지 않은 경우, 카카오 계정으로 로그인(loginWithKakaoAccount);
                      try {
                        await UserApi.instance.loginWithKakaoAccount();
                        print('카카오계정으로 로그인 성공');
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (_) => ChangeNotifierProvider(
                              create: (_) => EnterCheck(),
                              child: HomeScreen(),
                            )));
                        _get_user_info();
                      } catch (error) {
                        print('카카오계정으로 로그인 실패 $error');
                      }
                    }
                  } else {
                    try {
                      await UserApi.instance.loginWithKakaoAccount();
                      print('카카오계정으로 로그인 성공');
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (_) => ChangeNotifierProvider(
                            create: (_) => EnterCheck(),
                            child: HomeScreen(),
                          )));
                      _get_user_info();
                    } catch (error) {
                      print('카카오계정으로 로그인 실패 $error');
                    }
                  }
                }
              ),
            ),
          ],
        ));
  }
}
