import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyExercise extends StatefulWidget {
  const MyExercise({Key? key}) : super(key: key);

  @override
  _MyExerciseState createState() => _MyExerciseState();
}

class _MyExerciseState extends State<MyExercise> {
  static LatLng defaultLatlng = LatLng(37.435308, 127.138625);
  static CameraPosition initialPosition =
      CameraPosition(target: defaultLatlng, zoom: 15);
  static Circle defaultCircle = Circle(
    circleId: CircleId('circle'),
    radius: 100,
    center: defaultLatlng,
    fillColor: Colors.grey.withOpacity(0.3),
    strokeWidth: 1,
  );
  static Marker defaultMarker =
      Marker(markerId: MarkerId('marker'), position: defaultLatlng);
  late GoogleMapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('대기실 생성'),
        centerTitle: true,
      ),
      body: renderGmap(),
    );
  }

  Widget renderGmap() {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: FutureBuilder(
            future: Geolocator.getCurrentPosition(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData == false) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              Position position = snapshot.data;
              defaultLatlng = LatLng(position.latitude, position.longitude);
              initialPosition = CameraPosition(target: defaultLatlng, zoom: 15);
              return GoogleMap(
                onMapCreated: (controller) {
                  setState(() {
                    _controller = controller;
                  });
                },
                initialCameraPosition: initialPosition,
                circles: {defaultCircle},
                markers: {defaultMarker},
                onTap: (LatLng index) {
                  setState(() {
                    defaultLatlng = index;
                    _controller.animateCamera(CameraUpdate.newLatLng(index));
                    defaultMarker =
                        Marker(markerId: MarkerId('marker1'), position: index);
                    defaultCircle = Circle(
                      circleId: CircleId('circle1'),
                      radius: 100,
                      center: index,
                      fillColor: Colors.grey.withOpacity(0.3),
                      strokeWidth: 1,
                    );
                  });
                },
              );
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('대기실 설정1'),
              Text('대기실 설정2'),
              ElevatedButton(
                onPressed: () {
                  print(defaultLatlng);
                },
                child: Text('방 생성'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
