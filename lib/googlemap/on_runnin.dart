import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<LatLng> movePath = [];
Set<Polyline> polyline = {};

class OnRunningScreen extends StatefulWidget {
  const OnRunningScreen({Key? key}) : super(key: key);

  @override
  _OnRunningScreenState createState() => _OnRunningScreenState();
}

class _OnRunningScreenState extends State<OnRunningScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: Geolocator.getCurrentPosition(),
              builder:
                  (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData == false) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                late GoogleMapController _controller;
                movePath.clear();
                polyline.clear();

                return StreamBuilder<Position>(
                  stream: Geolocator.getPositionStream(),
                  builder: (BuildContext context,
                      AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData == false) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    Position po = snapshot.data;
                    LatLng laln = LatLng(po.latitude, po.longitude);
                    movePath.add(laln);
                    polyline.add(
                      Polyline(
                          polylineId: PolylineId(snapshot.data.toString()),
                          visible: true,
                          points: movePath,
                          color: Colors.blue),
                    );

                    return GoogleMap(
                      onMapCreated: (controller) {
                        setState(() {
                          _controller = controller;
                        });
                      },
                      initialCameraPosition:
                          CameraPosition(target: laln, zoom: 17),
                      markers: {
                        Marker(markerId: MarkerId('m'), position: laln)
                      },
                      polylines: polyline,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
