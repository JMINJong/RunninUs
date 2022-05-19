// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_web_auth/flutter_web_auth.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'auth_dio.dart';
// import 'package:runnin_us/api/api.dart';
//
// final kAppUrlScheme = '';
//
// Future<void> signIn(String api) async {
//   final storage = new FlutterSecureStorage();
//   try {
//     // open login page & redirect auth code to back-end
//     final url = Uri.parse('$api?redirect_uri=$kAppUrlScheme');
//
//     // get callback data from back-end
//     final result = await FlutterWebAuth.authenticate(
//         url: url.toString(), callbackUrlScheme: kAppUrlScheme);
//
//     // parsing accessToken & refreshToken from callback data
//     final accessToken = Uri.parse(result).queryParameters['access-token'];
//     final refreshToken = Uri.parse(result).queryParameters['refresh-token'];
//
//     // save tokens on secure storage
//     await storage.write(key: 'ACCESS_TOKEN', value: accessToken);
//     await storage.write(key: 'REFRESH_TOKEN', value: refreshToken);
//   } catch (e) {
//     showLoginFailDialog(e.toString());
//   }
//
//   await Firebase.initializeApp();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//
//   var dio = await authDio(context);
//
//   // firebase token update
//   final isFCMEnabled = await prefs.getBool('FCM_ENABLED');
//   if (isFCMEnabled == null || isFCMEnabled) {
//     String? firebaseToken = await FirebaseMessaging.instance.getToken();
//
//     if (firebaseToken != null) {
//       final firebaseTokenUpdateResponse = await dio.put(
//           getApi(API.UPDATE_TOKEN),
//           data: {'pushToken': firebaseToken});
//     }
//   }
//
//   final getUserStoreListResponse = await dio.get(getApi(API.GET_USER_STORES));
//   final storeList = getUserStoreListResponse.data;
//
//
//   Widget nextScreen;
//
//   if (storeList.length == 0){
//     nextScreen = CreateStoreIntroScreen();
//   }
//   else {
//     final selectedStoreId = storeList.last['id'];
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setInt('selectedStore', selectedStoreId);
//     context.read<SelectedStore>().id = selectedStoreId;
//     nextScreen = MainPage();
//   }
//
//   Navigator.of(context).pushAndRemoveUntil(
//       slidePageRouting(nextScreen), (Route<dynamic> route) => false);
// }
