import 'package:flutter/material.dart';
import 'package:runnin_us/screen/map/google_map.dart';
import 'package:runnin_us/screen/home_screen.dart';
import 'package:runnin_us/screen/init_screen.dart';
import 'package:runnin_us/screen/auth/login.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: InitScreen(),
    theme: ThemeData(
      primarySwatch: Colors.grey,
    ),
  ));
}
