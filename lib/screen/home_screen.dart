import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:runnin_us/screen/run/google_map.dart';
import 'package:runnin_us/screen/reserved_room_screen.dart';
import 'package:runnin_us/screen/store_screen.dart';
import 'package:runnin_us/screen/waiting_room_screen.dart';

import 'my_page_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentindex = 0;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  void initState() {
    Geolocator.isLocationServiceEnabled();
    Geolocator.checkPermission();
    Geolocator.requestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('RunninUs'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        bottomNavigationBar: _bottomNavi(),
        body: WillPopScope(
          onWillPop: (){
            return Future(()=>false);
          },
          child: PageView(

            controller: pageController,
            onPageChanged: (int index) {
              setState(() {
                currentindex = index;
                if (index == 0) {
                  print('데이터 받아오기');
                }
              });
            },
            children: [
              WaitingRoomScreen(),
              ReservedRoomScreen(),
              MyPageScreen(),
              StoreScreen(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomNavi() {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.indigo,
      unselectedItemColor: Colors.black,
      currentIndex: currentindex,
      onTap: (int index) {
        setState(
          () {
            currentindex = index;
            pageController.animateToPage(index,
                duration: Duration(milliseconds: 500), curve: Curves.ease);
          },
        );
      },
      items: [
        BottomNavigationBarItem(label: '대기실', icon: Icon(Icons.home)),
        BottomNavigationBarItem(
            label: '예약실', icon: Icon(Icons.watch_later_outlined)),
        BottomNavigationBarItem(label: '내 정보', icon: Icon(Icons.man)),
        BottomNavigationBarItem(label: '스토어', icon: Icon(Icons.attach_money)),
      ],
    );
  }
}
