import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:runnin_us/const/color.dart';
import 'package:runnin_us/screen/main/main_screen.dart';
import 'package:runnin_us/screen/main/my_page_screen.dart';
import 'package:runnin_us/screen/main/reserved_room_screen.dart';
import 'package:runnin_us/screen/main/store_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentindex = 0;
  Color mainColor = MINT_COLOR;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  DateTime? currentBackPressTime;

  @override
  void initState() {
    Geolocator.isLocationServiceEnabled();
    Geolocator.checkPermission();
    Geolocator.requestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          appBar: AppBar(
            title: Text('RunninUs'),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: mainColor,
          ),
          bottomNavigationBar: _bottomNavi(),
          body: SafeArea(
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
                MainScreen(),
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
      selectedItemColor: mainColor,
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
        BottomNavigationBarItem(label: '내 정보', icon: Icon(Icons.person)),
        BottomNavigationBarItem(
            label: '스토어', icon: Icon(Icons.local_grocery_store)),
      ],
    );
  }

  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: "'뒤로' 버튼을 한번 더 누르시면 종료됩니다.",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xff6E6E6E),
          fontSize: 20,
          toastLength: Toast.LENGTH_SHORT);
      return false;
    }
    return true;
  }
}
