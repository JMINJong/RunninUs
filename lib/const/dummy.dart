//대기실 만드는 리스트
//방장, 위도, 경도, 난이도, 시작시간, 종료시간, 날짜
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List waitingRoom = [
  {
    'roomName': '어서오세요',
    'host': 'jeon minjong',
    'latitude': '37.435288',
    'longitude': '127.1385',
    'runningLength': 5,
    'level': '4',
    'startTime': '17:30',
    'endTime': '18:30',
    'month': '5',
    'day': '25',
    'maxMember': '4',
    'member': [
      '김개똥',
      '이박문',
    ],
  },
  {
    'roomName': '달려봅시다',
    'host': 'jeon minjong',
    'latitude': '37.435288',
    'longitude': '127.1385',
    'runningLength': 8,
    'level': '4',
    'startTime': '17:30',
    'endTime': '18:30',
    'month': '5',
    'day': '25',
    'maxMember': '3',
    'member': [
      'member1',
      'member2',
    ],
  },
  {
    'roomName': '초보자 환영',
    'host': 'jeon minjong',
    'latitude': '37.435288',
    'longitude': '127.1385',
    'runningLength': 15,
    'level': '9',
    'startTime': '17:30',
    'endTime': '18:30',
    'month': '5',
    'day': '25',
    'maxMember': '4',
    'member': [],
  },
];

//유저 개인정보
//이름, 나이, 위치, 부여받은 등급, 매너점수, 마지막 등급 측정 기록, 현재 보유중 포인트
List myPageList = [
  { 

    'uid': 5,

    'name': '이준희',
    'age': '25',
    'location': '성남',
    'level': '4',
    'score': '3.14',
    'recent': '3:15',
    'point': '90'
  }
];

List recievedUserInfo = [];

int myPoint = 3000;

//현재 입장중인 대기실의 정보
//방장, 위도, 경도, 시작 시간, 종료 시간, 달리기 레벨, 참여자 정보(max4)
// Map enteredWaitingRoom = {
//   'host': 'host',
//   'latitude': '37.435288',
//   'longitude': '127.1385',
//   'startTime': '17:30',
//   'endTime': '18:30',
//   'level': '4',
//   'member': {
//     'mem1': 'member1',
//     'mem2': 'member2',
//     'mem3': 'member3',
//   },
// };
//
// Map enteredWaitingRoom2 = {
//   'host': '',
//   'latitude': '',
//   'longitude': '',
//   'startTime': '',
//   'endTime': '',
//   'level': '',
//   'member': {
//     'mem1': 'member1',
//     'mem2': 'member2',
//     'mem3': 'member3',
//   },
// };

Map myEnteredRoom = {
  'roomId': -1,
  'roomName': '',
  'host': '',
  'latitude': '',
  'longitude': '',
  'startTime': '',
  'runningLength': '',
  'endTime': '',
  'level': '',
  'mamMember': '',
  'member': [],
};

Map resultExercise = {
  'totalLength': '',
  'totalTime': '',
  'averageSpeed': '',
  'kcal': '',
};
//사용자 메인화면 진입시 찍히는 현재 위치
Position? currentPosition;

//사용자 운동중 생기는 경로 집합
Set<Polyline> polyline = {};

//운동검증에 필요한 데이터
Map exerciseAuthentication = {
  'totalLength': '',
  'totalTime': '',
  'averageSpeed': '',
  'level': '',
};
