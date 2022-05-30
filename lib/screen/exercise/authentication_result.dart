import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runnin_us/const/color.dart';
import '../../const/dummy.dart';

class AuthenticationResult extends StatelessWidget {
  const AuthenticationResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LatLng laln = LatLng(currentPosition!.latitude, currentPosition!.longitude);
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('RunninUs'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: MINT_COLOR,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            // decoration: BoxDecoration(
            //   border: Border.all(color: MINT_COLOR, width: 2),
            // ),
            // height: MediaQuery.of(context).size.height - kToolbarHeight - 32,
            // width: MediaQuery.of(context).size.width,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 20,
                  decoration: BoxDecoration(
                    border: Border.all(color: MINT_COLOR, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '검증 결과',
                        style: TextStyle(
                            fontSize: 30,
                            color: MINT_COLOR,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child: GoogleMap(
                    myLocationButtonEnabled: false,
                    initialCameraPosition:
                        CameraPosition(target: laln, zoom: 15),
                    polylines: polyline,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: MINT_COLOR, width: 2),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '달린 거리 : ${exerciseAuthentication['totalLength'].split('.')[0]} m',
                          style: TextStyle(fontSize: 20, color: PINK_COLOR),
                        ),
                        Text(
                          '달린 시간 : ${exerciseAuthentication['totalTime']} ',
                          style: TextStyle(fontSize: 20, color: PINK_COLOR),
                        ),
                        Text(
                          '평균 속력 : ${exerciseAuthentication['averageSpeed']} k/m',
                          style: TextStyle(fontSize: 20, color: PINK_COLOR),
                        ),
                        Text(
                          '레벨 : ${exerciseAuthentication['level']} ',
                          style: TextStyle(fontSize: 20, color: PINK_COLOR),
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    myPageList[0]['level']=exerciseAuthentication['level'];

                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: MINT_COLOR,
                  ),
                  child: Text('확인'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
