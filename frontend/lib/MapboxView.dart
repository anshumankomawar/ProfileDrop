import 'package:flutter_map/flutter_map.dart';
import 'package:user_location/user_location.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Database.dart';
import 'package:latlong2/latlong.dart' as latlng;

class MapboxView extends StatefulWidget {
  const MapboxView({Key? key}) : super(key: key);


  @override
  _MapboxViewState createState() => _MapboxViewState();
}

class _MapboxViewState extends State<MapboxView> {
  MapController mapController = MapController();
  late UserLocationOptions userLocationOptions;
  List<Marker> markers = [
    Marker(
      point: latlng.LatLng(35.2828, -120.6596),
      builder: (BuildContext context) { return Container(
        decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
        width: 12,
        height: 12,
        padding: const EdgeInsets.all(10),
      ); },
      width: 30.0,
      height: 30.0,)];
  @override
  Widget build(BuildContext context) {
    MongoDatabase.getDocuments();

    userLocationOptions = UserLocationOptions(
      context: context,
      mapController: mapController,
      markers: markers,
    );
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
          userLocationOptions,
        ],
        mapController: mapController,
    );
  }
}
