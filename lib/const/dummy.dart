
//대기실 만드는 리스트
List waitingRoom = [
  {
    'host': 'jeon min jong',
    'latitude': '37.435288',
    'longitude': '127.1385',
    'level': '4',
    'startTime': '17:30',
    'endTime': '18:30',
    // 'point': '15000',
    'month': '5',
    'day': '25',
  },
  {
    //판교역
    'host': 'lee jun hee',
    'latitude': '37.392860',
    'longitude': '127.112009',
    'level': '4',
    'startTime': '17:30',
    'endTime': '18:30',
    'point': '15000'
  },
  {
    //경인지방법무청
    'host': 'lee gil ya',
    'latitude': '37.280229',
    'longitude': '127.127007192',
    'level': '4',
    'startTime': '17:30',
    'endTime': '18:30',
    'point': '15000'
  },
  {
    'host': 'jeon min jong',
    'latitude': '37.435288',
    'longitude': '127.1385',
    'level': '4',
    'startTime': '17:30',
    'endTime': '18:30',
    'point': '15000',
    'month': '5',
    'day': '25',
  },
  {
    //판교역
    'host': 'lee jun hee',
    'latitude': '37.392860',
    'longitude': '127.112009',
    'level': '4',
    'startTime': '17:30',
    'endTime': '18:30',
    'point': '15000'
  },
  {
    //경인지방법무청
    'host': 'lee gil ya',
    'latitude': '37.280229',
    'longitude': '127.127007192',
    'level': '4',
    'startTime': '17:30',
    'endTime': '18:30',
    'point': '15000'
  },
  {
    'host': 'jeon min jong',
    'latitude': '37.435288',
    'longitude': '127.1385',
    'level': '4',
    'startTime': '17:30',
    'endTime': '18:30',
    'point': '15000',
    'month': '5',
    'day': '25',
  },
  {
    //판교역
    'host': 'lee jun hee',
    'latitude': '37.392860',
    'longitude': '127.112009',
    'level': '4',
    'startTime': '17:30',
    'endTime': '18:30',
    'point': '15000'
  },
  {
    //경인지방법무청
    'host': 'lee gil ya',
    'latitude': '37.280229',
    'longitude': '127.127007192',
    'level': '4',
    'startTime': '17:30',
    'endTime': '18:30',
    'point': '15000'
  },
  {
    'host': 'jeon min jong',
    'latitude': '37.435288',
    'longitude': '127.1385',
    'level': '4',
    'startTime': '17:30',
    'endTime': '18:30',
    'point': '15000',
    'month': '5',
    'day': '25',
  },
  {
    //판교역
    'host': 'lee jun hee',
    'latitude': '37.392860',
    'longitude': '127.112009',
    'level': '4',
    'startTime': '17:30',
    'endTime': '18:30',
    'point': '15000'
  },
  {
    //경인지방법무청
    'host': 'lee gil ya',
    'latitude': '37.280229',
    'longitude': '127.127007192',
    'level': '4',
    'startTime': '17:30',
    'endTime': '18:30',
    'point': '15000'
  },
];

List myPageList = [
  {
    'name': 'lee jun hee',
    'age': '25',
    'location': '성남',
    'level': '4',
    'score': '3.14',
    'recent': '3:15',
    'point': '90'
  }
];

int myPoint = 3000;

//현재 입장중인 대기실의 정보
//방장, 위도, 경도, 시작 시간, 종료 시간, 달리기 레벨, 참여자 정보(max4)
Map enteredWaitingRoom = {
  'host': 'host',
  'latitude': '37.435288',
  'longitude': '127.1385',
  'startTime': '17:30',
  'endTime': '18:30',
  'level': '4',
  'member': {
    'mem1': 'member1',
    'mem2': 'member2',
    'mem3': 'member3',
  },
};



bool isEntered = true;

List levelList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
