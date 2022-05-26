import 'package:flutter/material.dart';
import 'package:runnin_us/const/dummy.dart';
import 'package:dio/dio.dart';
import 'api_generator.dart';

Future<bool> updateUserInfoApi() async {

  try {
    var dio = await Dio().request(
      getApi(API.UPDATE_USER_INFO),
      data: {
        "user_id": myPageList[0]['uid'],
        "user_nick": myPageList[0]['name'],
        "user_age": myPageList[0]['age'],
        "user_sex": myPageList[0]['sex'],
        "user_address": myPageList[0]['location'],
      },
      options: Options(method: 'POST'),
    );
    var updatedUserInfo=dio.data['message'];
    print(updatedUserInfo);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}