import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runnin_us/api/get_members_waiting_room_api.dart';
import 'package:runnin_us/const/color.dart';
import 'package:runnin_us/screen/exercise/mutual_evaluation.dart';
import '../../const/dummy.dart';

//운동결과 페이지

class ExerciseResult extends StatefulWidget {
  const ExerciseResult({Key? key}) : super(key: key);

  @override
  _ExerciseResultState createState() => _ExerciseResultState();
}

class _ExerciseResultState extends State<ExerciseResult> {
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
                        '운동 결과',
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
                          '달린 거리 : ${resultExercise['totalLength'].split('.')[0]} m',
                          style: TextStyle(fontSize: 20, color: PINK_COLOR),
                        ),
                        Text(
                          '달린 시간 : ${resultExercise['totalTime']} ',
                          style: TextStyle(fontSize: 20, color: PINK_COLOR),
                        ),
                        Text(
                          '평균 속력 : ${resultExercise['averageSpeed']} k/m',
                          style: TextStyle(fontSize: 20, color: PINK_COLOR),
                        ),
                        Text(
                          '소모 칼로리 : ${resultExercise['kcal']} kcal',
                          style: TextStyle(fontSize: 20, color: PINK_COLOR),
                        ),
                        Text(
                          '예상 획득 포인트 : 1065',
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
                  onPressed: () async {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => MutualEvaluation(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: MINT_COLOR,
                  ),
                  child: Text('다음으로'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
