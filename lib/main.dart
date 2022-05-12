import 'package:flutter/material.dart';
import 'package:runnin_us/screen/auth/init_screen.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

void main() {
  KakaoSdk.init(nativeAppKey: '58b636141acc87e8a31b06d844add97d');
  runApp(MaterialApp(
    home: InitScreen(),
  ));
}