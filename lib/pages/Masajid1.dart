// // بسم الله الرحمن الرحيم
// // O' Tuhan namu papag-barakata kamu in Application ini
// // sarta tarbilanga kami dayng ha mga Mukhliseen. Ameen
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:latlong/latlong.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:tausug_tafseer/controllers/MasajidController.dart';
// import 'package:tausug_tafseer/style/Hex.dart';

// class Masajid extends StatefulWidget {
//   Masajid({Key key}) : super(key: key);

//   @override
//   _MasajidState createState() => _MasajidState();
// }

// class _MasajidState extends State<Masajid> {
//   MapController controller = new MapController();
//   Position position;
//   Widget _child;

//   Future<void> getPermission() async {
//     PermissionStatus permission = await Permission.location.status;

//     if (permission == PermissionStatus.denied ||
//         permission == PermissionStatus.undetermined) {
//       await Permission.locationAlways.request();
//     }

//     var geolocator = Geolocator();

//     GeolocationStatus geolocationStatus =
//         await geolocator.checkGeolocationPermissionStatus();

//     switch (geolocationStatus) {
//       case GeolocationStatus.denied:
//         showToast('Access Denied');
//         break;
//       case GeolocationStatus.disabled:
//         showToast('Disabled');
//         break;
//       case GeolocationStatus.restricted:
//         showToast('Restricted');
//         break;
//       case GeolocationStatus.unknown:
//         showToast('Unknown');
//         break;
//       case GeolocationStatus.granted:
//         showToast('Access Granted');
//         _getCurrentLocation();
//     }
//   }

//   void _getCurrentLocation() async {
//     Position res = await Geolocator().getCurrentPosition();
//     setState(() {
//       position = res;
//       _child = _mapWidget();
//     });
//   }

//   void showToast(message) {
//     Fluttertoast.showToast(
//         msg: message,
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIos: 1,
//         backgroundColor: Color(hexColor('#216353')),
//         textColor: Colors.white,
//         fontSize: 14.0);
//   }

//   @override
//   void initState() {
//     getPermission();
//     super.initState();
//   }

//   Widget _mapWidget() {
//     return new FlutterMap(
//         options: new MapOptions(
//             center: new LatLng(position.latitude, position.longitude),
//             minZoom: 14.0),
//         layers: [
//           new TileLayerOptions(
//               urlTemplate:
//                   "http://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png",
//               // https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png
//               // urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//               subdomains: ['a', 'b', 'c']),
//           new MarkerLayerOptions(markers: [
//             new Marker(
//                 width: 45.0,
//                 height: 45.0,
//                 point: new LatLng(position.latitude, position.longitude),
//                 builder: (context) => new Container(
//                         child: Transform.scale(
//                       scale: 1.5,
//                       child: IconButton(
//                         icon: new Icon(Icons.location_on),
//                         color: Colors.blue,
//                         onPressed: () {
//                           print('Test123');
//                         },
//                       ),
//                     ))),
//             recodoLappasan,
//             recodoAwwal,
//             recodoDarusSalam,
//             recodoKasalamatan,
//             recodoLanjang
//           ]),
//           CircleLayerOptions(circles: [
//             new CircleMarker(
//                 point: LatLng(position.latitude, position.longitude),
//                 color: Colors.blueAccent.withOpacity(0.2),
//                 borderStrokeWidth: 1.0,
//                 borderColor: Colors.blueAccent,
//                 radius: 40),
//             // atTaawunCircleMarker,
//           ]),
//         ]);
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Masājid'),
//         centerTitle: true,
//       ),
//       body: _child,

//       // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
