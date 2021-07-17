// بسم الله الرحمن الرحيم
// O' Tuhan namu papag-barakata kamu in Application ini
// sarta tarbilanga kami dayng ha mga Mukhliseen. Ameen
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:tausug_tafseer/controllers/Masajid.dart';
import 'package:tausug_tafseer/controllers/MasajidController.dart';
import 'package:tausug_tafseer/controllers/Surah.dart';
import 'package:tausug_tafseer/models/MasajidModel.dart';
import 'package:tausug_tafseer/style/Hex.dart';

class Masajid extends StatefulWidget {
  Masajid({
    Key key,
    // this.location,
    // this.masjid,
    // this.lat,
    // this.long,
  }) : super(key: key);

  // final String location, masjid;
  // final double lat, long;
  @override
  _MasajidState createState() => _MasajidState();
}

class _MasajidState extends State<Masajid> {
  double currentZoom = 15.0;
  MapController controller = new MapController();
  Position position;
  Widget _child;

  void _zoom() {
    currentZoom = currentZoom - 1;
    controller.move(_center, currentZoom);
  }

  LatLng _center;

  Future<void> getPermission() async {
    PermissionStatus permission = await Permission.location.status;

    if (permission == PermissionStatus.denied ||
        permission == PermissionStatus.undetermined) {
      await Permission.locationAlways.request();
    }

    var geolocator = Geolocator();

    Future<Position> _determinePosition() async {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      return await Geolocator.getCurrentPosition();
    }

    showToast('Access Granted');
    _getCurrentLocation();
    // LocationPermission geolocationStatus =
    //     await geolocator.checkGeolocationPermissionStatus();

    // switch (geolocationStatus) {
    //   case LocationPermission.denied:
    //     showToast('Access Denied');
    //     break;
    //   case LocationPermission.disabled:
    //     showToast('Disabled');
    //     break;
    //   case LocationPermission.restricted:
    //     showToast('Restricted');
    //     break;
    //   case LocationPermission.unknown:
    //     showToast('Unknown');
    //     break;
    //   case LocationPermission.granted:
    //     showToast('Access Granted');
    //     _getCurrentLocation();
    // }
  }

  void _getCurrentLocation() async {
    Position res = await Geolocator.getCurrentPosition();
    setState(() {
      position = res;
      _center = LatLng(position.latitude, position.longitude);
      _child = _mapWidget();
    });
  }

  void showToast(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Color(hexColor('#216353')),
        textColor: Colors.white,
        fontSize: 14.0);
  }

  List<Marker> allMarkers = [];

  @override
  void initState() {
    getPermission();
    super.initState();
  }

  Widget _mapWidget() {
    return FutureBuilder<List<MgaMasjid>>(
        future: Service().loadMasajid(),
        builder: (c, snapshot) {
          if (snapshot.hasData) {
            List<MgaMasjid> masajid = snapshot.data;
            masajid.forEach((element) {
              allMarkers = masajid
                  .map((e) => Marker(
                      point: new LatLng(e.lat, e.long),
                      width: 45.0,
                      height: 45.0,
                      builder: (context) => new Container(
                              child: Transform.scale(
                            scale: 1.5,
                            child: IconButton(
                              icon: new Image.asset("images/Masjid_Marker.png"),
                              onPressed: () {
                                print('Test123');
                              },
                            ),
                          ))))
                  .toList(growable: true);
            });
            return FlutterMap(
                options: MapOptions(
                  center: LatLng(position.latitude, position.longitude),
                  minZoom: 12.0,
                ),
                layers: [
                  new TileLayerOptions(
                      urlTemplate:
                          // "https://server.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}",
                          // "http://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png",
                          "https://api.mapbox.com/styles/v1/melonz/cknwalnof2a9w17scuze4bztb/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWVsb256IiwiYSI6ImNrbndhZzd4bjBxaDAzMXFxa201bzhpNmYifQ.ea5KDMTnaIggz5aIVhumsw",
                      additionalOptions: {
                        'accessToken':
                            'pk.eyJ1IjoibWVsb256IiwiYSI6ImNrbndhZzd4bjBxaDAzMXFxa201bzhpNmYifQ.ea5KDMTnaIggz5aIVhumsw',
                        'id': 'mapbox.mapbox-streets-v8'
                      },
                      // "http://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png",
                      // https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png
                      // urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: [
                        'a',
                        'b',
                        'c'
                      ]),
                  MarkerLayerOptions(
                    markers: allMarkers,
                  ),
                  MarkerLayerOptions(markers: [
                    Marker(
                        width: 45.0,
                        height: 45.0,
                        point: LatLng(position.latitude, position.longitude),
                        builder: (context) => new Container(
                                child: Transform.scale(
                              scale: 1.5,
                              child: IconButton(
                                icon: new Icon(Icons.location_on),
                                color: Colors.blue,
                                onPressed: () {
                                  print('Test123');
                                },
                              ),
                            ))),
                  ]),
                  CircleLayerOptions(circles: [
                    new CircleMarker(
                        point: LatLng(position.latitude, position.longitude),
                        color: Colors.blueAccent.withOpacity(0.2),
                        borderStrokeWidth: 1.0,
                        borderColor: Colors.blueAccent,
                        radius: 30),
                    // atTaawunCircleMarker,
                  ]),
                ]);
          }
          return Center(child: CircularProgressIndicator());
        });
    // FlutterMap(
    //     options: new MapOptions(
    //         center: new LatLng(position.latitude, position.longitude),
    //         minZoom: 14.0),
    //     layers: [
    //       new TileLayerOptions(
    //           urlTemplate:
    //               "http://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png",
    //           // https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png
    //           // urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
    //           subdomains: ['a', 'b', 'c']),
    //       new MarkerLayerOptions(markers: [
    //         new Marker(
    //             width: 45.0,
    //             height: 45.0,
    //             point: new LatLng(position.latitude, position.longitude),
    //             builder: (context) => new Container(
    //                     child: Transform.scale(
    //                   scale: 1.5,
    //                   child: IconButton(
    //                     icon: new Icon(Icons.location_on),
    //                     color: Colors.blue,
    //                     onPressed: () {
    //                       print('Test123');
    //                     },
    //                   ),
    //                 ))),
    //         recodoLappasan,
    //         // recodoAwwal,
    //         // recodoDarusSalam,
    //         // recodoKasalamatan,
    //         // recodoLanjang
    //       ]),
    //       CircleLayerOptions(circles: [
    //         new CircleMarker(
    //             point: LatLng(position.latitude, position.longitude),
    //             color: Colors.blueAccent.withOpacity(0.2),
    //             borderStrokeWidth: 1.0,
    //             borderColor: Colors.blueAccent,
    //             radius: 40),
    //         // atTaawunCircleMarker,
    //       ]),
    //     ]);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Masājid'),
          centerTitle: true,
        ),
        body: _child,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(hexColor('#216353')),
          child: Icon(
            Icons.my_location_outlined,
            size: 40,
            color: Colors.white,
          ),
          onPressed: _zoom,
          tooltip: 'Zoom',
        )

        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
