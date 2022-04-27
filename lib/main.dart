import 'package:flutter/material.dart';
import 'package:runnin_us/screen/google_map.dart';
import 'package:runnin_us/screen/home_screen.dart';
import 'package:runnin_us/screen/init_screen.dart';
import 'package:runnin_us/screen/login.dart';

void main() {
  runApp(MaterialApp(
    home: InitScreen(),
    theme: ThemeData(
primarySwatch: Colors.grey,
    ),
  ));
}
