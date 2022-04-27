import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runnin_us/const/color.dart';
import 'package:runnin_us/const/const.dart';
import 'package:runnin_us/googlemap/google_map.dart';

TextStyle ts=TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontWeight: FontWeight.w400,
);

class WaitingRoomScreen extends StatefulWidget {
  const WaitingRoomScreen({Key? key}) : super(key: key);

  @override
  State<WaitingRoomScreen> createState() => _WaitingRoomScreenState();
}

class _WaitingRoomScreenState extends State<WaitingRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => MyExercise(),
                        ),
                      );
                    },
                    child: Text('대기실 생성'),
                    style: ElevatedButton.styleFrom(
                      primary: MINT_COLOR,
                    ),
                  ),
                ],
              ),
            )),
        Expanded(
          flex: 7,
          child: ListView.separated(
              itemBuilder: (context, index) {
                return renderWaitingRoom(index);
              },
              separatorBuilder: (context, index) {
                if (index % 8 == 0 && index != 0) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Text('${index} 광고 노출 배너'),
                  );
                }
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  child: Text('$index'),
                );
              },
              itemCount: waitingRoom.length),
        ),
      ],
    );
  }

  renderWaitingRoom(int index) {
    final LatLng latlng = LatLng(double.parse(waitingRoom[index]['latitude']),
        double.parse(waitingRoom[index]['longitude']));
    final CameraPosition cp = CameraPosition(target: latlng, zoom: 17);
    final Marker marker=Marker(markerId: MarkerId('marker$index'),position: latlng);
    print(marker.markerId);
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>MyExercise()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: MINT_COLOR.withOpacity(0.7),
        ),
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 100,
              width: 100,
              child: GoogleMap(
                onTap: (value) {
                  showModalBottomSheet(
                      context: context, builder: (BuildContext context) {
                        return Container(
                          height: MediaQuery.of(context).size.height/2,
                          child: GoogleMap(
                            initialCameraPosition: cp,
                            markers: {marker},
                          ),
                        );
                  });
                },
                zoomControlsEnabled: false,
                initialCameraPosition: cp,
              ),
            ),
            Text('${waitingRoom[index]['host']},',style: ts,),
            Text('${waitingRoom[index]['startTime']}',style: ts,),
            Text('${waitingRoom[index]['endTime']}',style: ts,),
            Text('${waitingRoom[index]['level']}',style: ts,),
          ],
        ),
      ),
    );
  }
}
