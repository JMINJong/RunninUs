import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

// STEP1:  Stream setup
class StreamSocket {
  final _socketResponse = StreamController();

  void Function(dynamic) get addResponse => _socketResponse.sink.add;

  Stream get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}
//ws://echo.websocket.org
//http://runninus-api.befined.com:8000

//STEP2: Add this function in main function in main.dart file and add incoming data to the stream
void connectAndListen() {
  IO.Socket socket = IO.io('http://runninus-api.befined.com:8000',
      OptionBuilder().setTransports(['websocket']).build());

  socket.onConnect((_) {
    print('connect');
    // socket.emit('msg', 'test');
    // socket.emit('PING');
  });
  // socket.emit('PING');

  //When an event recieved from server, data is added to the stream
  socket.on('event', (data) => StreamSocket().addResponse);

  socket.on('PONG', (data) {
    print('PONG');
    StreamSocket().addResponse('pong');
  });
  socket.on('MEET_CONNECTED', (data) {
    //{meetId} 날아옴
    print('MEET_CONNECTED');
  });


  socket.on('USER_IN', (data) {
    //{userUid}날아옴
    print('USER_IN');

    StreamSocket().addResponse(data);


  });


  socket.onDisconnect((_) => print('disconnect'));


}

void socketTest() {
  IO.Socket socket = IO.io('http://runninus-api.befined.com:8000');
  socket.emit('PING');
}

void socketRoomEnter(int userUid, int meetId) {
  IO.Socket socket = IO.io('http://runninus-api.befined.com:8000');
  socket.emit('MEET_IN', {
    "userUid": userUid,
    "meetId":meetId,
  });
}
