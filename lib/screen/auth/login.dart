import 'package:flutter/material.dart';
import 'package:runnin_us/screen/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(flex: 2,
                child: Image.asset('asset/img/main.png')),
            Expanded(flex: 1,
              child: IconButton(
                icon: Image.asset('asset/img/kakao_login.png'),
                iconSize: 400,
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
                },
              ),
            ),
          ],
        ));
  }
}
