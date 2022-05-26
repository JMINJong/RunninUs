import 'package:flutter/material.dart';
import 'package:runnin_us/const/dummy.dart';
import '../../const/color.dart';

//상호평가 페이지

class MutualEvaluation extends StatefulWidget {
  MutualEvaluation({Key? key}) : super(key: key);

  @override
  State<MutualEvaluation> createState() => _MutualEvaluationState();
}

class _MutualEvaluationState extends State<MutualEvaluation> {
  List member = myEnteredRoom['member'];

  List<double> evaluationPoint = [100, 100, 100, 100];

  int i = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RunninUs'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: MINT_COLOR,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: MINT_COLOR, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '맥박 수 평가',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: MINT_COLOR,
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: PINK_COLOR, width: 2),
                    // ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: member.asMap().entries.map(
                        (x) {
                          return Column(
                            children: [
                              Text(
                                '${x.value['NICK']}',
                                style: TextStyle(fontSize: 20),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Row(
                                  children: [
                                    Text(
                                      '0',
                                      style: TextStyle(
                                          color: PINK_COLOR,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20),
                                    ),
                                    Expanded(
                                      child: Slider(
                                        activeColor: PINK_COLOR,
                                        inactiveColor: MINT_COLOR,
                                        max: 200,
                                        value: evaluationPoint[x.key],
                                        onChanged: (double value) {
                                          setState(
                                            () {
                                              evaluationPoint[x.key] =
                                                  value.roundToDouble();
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    Text(
                                      '200',
                                      style: TextStyle(
                                          color: MINT_COLOR,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20),
                                    ),
                                  ],
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                ),
                              ),
                            ],
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: MINT_COLOR),
                  onPressed: () {
                    print(evaluationPoint);
                    Navigator.of(context).pop();
                  },
                  child: Text('평가완료'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
