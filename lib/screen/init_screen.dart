import 'package:flutter/material.dart';
import 'package:runnin_us/screen/home_screen.dart';
import 'package:runnin_us/screen/auth/login.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) => Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => LoginScreen())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('asset/img/main.png'),
            Text('RunninUs'),
            CircularProgressIndicator(
              color: Colors.blue,
            ),
          ],
        ));
  }
}
