import 'dart:async';
import 'package:runnin_us/api/get_user_nick.dart';
import 'package:runnin_us/const/dummy.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

// STEP1:  Stream setup
class StreamSocket {
  final _socketResponse = StreamController<String>.broadcast();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}

StreamSocket streamSocket = StreamSocket();
StreamSocket streamSocket2 = StreamSocket();

//ws://echo.websocket.org
//http://runninus-api.befined.com:8000

//STEP2: Add this function in main function in main.dart file and add incoming data to the stream
void connectAndListen() {
  IO.Socket socket = IO.io('http://runninus-api.befined.com:8000',
      OptionBuilder().setTransports(['websocket']).build());

  socket.onConnect(
    (_) {
      print('connect');
      // socket.emit('msg', 'test');
      // socket.emit('PING');
    },
  );
  // socket.emit('PING');

  //When an event recieved from server, data is added to the stream
  socket.on('event', (data) => StreamSocket().addResponse);

  socket.on(
    'PONG',
    (data) {
      print('PONG');

    },
  );
  socket.on(
    'MEET_CONNECTED',
    (data) {
      //{meetId} 날아옴


      print('MEET_CONNECTED');
      print(data);
      print(myEnteredRoom['member']);
      streamSocket.addResponse('1');
    },
  );

  socket.on(
    'USER_IN',
    (data) async{

      String? name=await GetUserNick(data['userUid']);
      //{userUid}날아옴
      print('USER_IN');
      print(data);
      // print(data['userUid']);
      myEnteredRoom['member'].add(name);
      streamSocket.addResponse('1');
      print(myEnteredRoom['member']);
    },
  );

  socket.on(
    'MEET_DISCONNECTED',
    (date) {
      print('MEET_DISCONNECTED');
    },
  );

  socket.on('RUNNING_START', (data) {
    print("RUNNING_START");
    print(data);
    print(data['status']);
    streamSocket.addResponse('${data['status']}');
  });

  socket.on('RUNNING_END', (data) {
    print("RUNNING_END");
    print(data);
    streamSocket2.addResponse('${data['status']}');
    print(data['status']);
  });

  socket.onDisconnect((_) => print('disconnect'));
}

void socketTest() {
  IO.Socket socket = IO.io('http://runninus-api.befined.com:8000');
  socket.emit('PING');
}

void socketRoomEnter(int userUid, int meetId, bool isRecover) {
  IO.Socket socket = IO.io('http://runninus-api.befined.com:8000');
  print('MEET_IN');
  // myEnteredRoom['member'].add(myPageList[0]['name']);


  socket.emit('MEET_IN', {
    "userUid": userUid,
    "meetId": meetId,
    'isRecover': isRecover,
  });
}

void socketRoomExit() {
  IO.Socket socket = IO.io('http://runninus-api.befined.com:8000');
  print('MEET_OUT');
  socket.emit('MEET_OUT');
}

void socketRoomStart() {
  IO.Socket socket = IO.io('http://runninus-api.befined.com:8000');
  print('MEET_START');
  socket.emit('MEET_START');
}

void socketRoomEnd() {
  IO.Socket socket = IO.io('http://runninus-api.befined.com:8000');
  print('MEET_END');
  socket.emit('MEET_END');
}
