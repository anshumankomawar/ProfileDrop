import 'package:flutter_map/flutter_map.dart';
import 'package:user_location/user_location.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' as latlng;

import 'OtherProfile.dart';
import 'models/User.dart';

class MapboxView extends StatefulWidget {
  final User user;
  final List<User> nearbyUsers;
  const MapboxView({required this.user, required this.nearbyUsers, Key? key}) : super(key: key);


  @override
  _MapboxViewState createState() => _MapboxViewState();
}

class _MapboxViewState extends State<MapboxView> {
  MapController mapController = MapController();
  late UserLocationOptions userLocationOptions;

  @override
  Widget build(BuildContext context) {
    print(widget.user.location.coordinates[0].toString() +  widget.user.location.coordinates[1].toString());
    List<Marker> markers = [
      Marker(
        point: latlng.LatLng(widget.user.location.coordinates[1], widget.user.location.coordinates[0]),
        builder: (BuildContext context) { return Container(
          decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
          width: 12,
          height: 12,
          padding: const EdgeInsets.all(10),
        ); },
        width: 30.0,
        height: 30.0,
      ),
    ];

    // print(widget.user.location)
    for (int i = 0; i < widget.nearbyUsers.length; i++) {
      markers.add(
          Marker(
            point:
            latlng.LatLng(widget.nearbyUsers[i].location.coordinates[1],
                widget.nearbyUsers[i].location.coordinates[0]),
            width: 30.0,
            height: 30.0,
            builder:  (BuildContext context) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OtherProfile(mainUser: widget.user, user: widget.nearbyUsers[i])),
                );
              },
              child: Container(
                decoration: BoxDecoration(color: Colors.green,
                    shape: BoxShape.circle),
                width: 12,
                height: 12,
                padding: const EdgeInsets.all(10),
              ),
            )));
    }

    return FlutterMap(
        options: MapOptions(
          center: latlng.LatLng(35.2828, -120.6596),
          zoom: 13.0,
          plugins: [
            UserLocationPlugin(),
          ],
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://api.mapbox.com/styles/v1/anshumankomawar/ckqx08cyy10y317qzdotemlbr/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYW5zaHVtYW5rb21hd2FyIiwiYSI6ImNrcXgwMWFpZDB0Z3Uyb3Foa2hqeHFoMTkifQ.HcpcpIVJ516sRW9JzhhSSw",
              additionalOptions: {
                'accessToken': 'pk.eyJ1IjoiYW5zaHVtYW5rb21hd2FyIiwiYSI6ImNrcXgwMWFpZDB0Z3Uyb3Foa2hqeHFoMTkifQ.HcpcpIVJ516sRW9JzhhSSw',
                'id': 'mapbox.mapbox-streets-v8'
              }
          ),
          MarkerLayerOptions(markers: markers),
          // UserLocationOptions(
          //     context: context,
          //     mapController: mapController,
          //     markers: markers,
          // )
        ],
        mapController: mapController,
    );
  }
}
