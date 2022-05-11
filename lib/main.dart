import 'package:flutter/material.dart';
import 'package:naver_api/dio.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String text = '네이버';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NaverAPI'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder(
        future: getHttp(text),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
          if (snapshot.hasData == false) {
            return CircularProgressIndicator();
          }
          //error가 발생하게 될 경우 반환하게 되는 부분
          else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontSize: 15),
              ),
            );
          }
          // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
          else {
            // print(snapshot.data.toList().asMap()[0]['title']);
            // print(snapshot.data.toList().asMap()[0]['description']);
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Input',
                        ),
                        onChanged: (value) {
                          text = value;
                        },
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            getHttp(text);
                             print(text);
                          });
                        },
                        child: Text('검색'))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2)),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height - 465,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(

                                      child: Text(snapshot.data
                                          .toList()
                                          .asMap()[index]['title']),
                                      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                    ),
                                    Text(snapshot.data.toList().asMap()[index]
                                        ['link']),
                                    Text(snapshot.data.toList().asMap()[index]
                                        ['description'])
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 16,
                                );
                              },
                              itemCount: 10)),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
