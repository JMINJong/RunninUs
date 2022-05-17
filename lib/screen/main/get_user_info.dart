import 'package:flutter/material.dart';
import 'package:runnin_us/const/color.dart';

class GetUserInfo extends StatefulWidget {
  const GetUserInfo({Key? key}) : super(key: key);

  @override
  _GetUserInfoState createState() => _GetUserInfoState();
}

class _GetUserInfoState extends State<GetUserInfo> {
  @override
  Widget build(BuildContext context) {
    String location='';
    String sex;

    return Scaffold(
      appBar: AppBar(
        title: Text('RunninUs'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: MINT_COLOR,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '지역',
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.always,
              onChanged: (value) {
                location=value;
              },
              validator: (value) {
                if (value == '') {
                  return '값을 입력해 주세요.';
                }
                return null;
              },
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text(
                  '추가정보1',
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.always,
              onChanged: (value) {},
              validator: (value) {
                if (value == '') {
                  return '값을 입력해 주세요.';
                }
                return null;
              },
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text(
                  '추가정보2',
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.always,
              onChanged: (value) {},
              validator: (value) {
                if (value == '') {
                  return '값을 입력해 주세요.';
                }
                return null;
              },
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                print(location);
                Navigator.of(context).pop();
              },
              child: Text('확인'),
              style: ElevatedButton.styleFrom(
                primary: MINT_COLOR,
              ),
            )
          ],
        ),
      ),
    );
  }
}
