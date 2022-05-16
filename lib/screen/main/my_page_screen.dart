import 'package:flutter/material.dart';
import 'package:runnin_us/const/color.dart';
import 'package:runnin_us/const/dummy.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).disableAnimations;
    return Scaffold(
        body: renderPageList(list: myPageList, index: 0)
    );
  }

  Widget renderPageList({
    required List list,
    required int index,
  }) {
    return ListView(
      children: [
        Card(
            child: ListTile(
              title: Center(child: Text('${myPageList[index]['name']}')),
            )
        ),
        Card(
          child: ListTile(
            title: Center(child: Text('${myPageList[index]['age']}')),
          ),
        ),
        Card(
            child: ListTile(
              title: Center(child: Text('${myPageList[index]['location']}')),
            )
        ),
        Card(
            child: ListTile(
              title: Center(child: Text('${myPageList[index]['level']}')),
            )
        ),
        Card(
            child: ListTile(
              title: Center(child: Text('${myPageList[index]['score']}')),
            )
        ),
        Card(
            child: ListTile(
              title: Center(child: Text('${myPageList[index]['recent']}')),
            )
        ),
        Card(
            child: ListTile(
              title: Center(child: Text('${myPageList[index]['point']}')),
            )
        ),
        ElevatedButton(
            onPressed: (){
              //
            },
            child: Text('재인증')
        ),
      ],
      padding: EdgeInsets.all(10),
      shrinkWrap: true,
    );
  }
}
