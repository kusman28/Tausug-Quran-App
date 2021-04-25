// // بسم الله الرحمن الرحيم
// // O' Tuhan namu papag-barakata kamu in Application ini
// // sarta tarbilanga kami dayng ha mga Mukhliseen. Ameen
// import 'package:adhan/adhan.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:intl/intl.dart';
// import 'package:location/location.dart';

// import '../main.dart';

// class WaktuNotification {
//   final location = new Location();
//   String locationError;
//   PrayerTimes prayerTimes;

//   Future<LocationData> getLocationData() async {
//     var _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         return null;
//       }
//     }

//     var _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return null;
//       }
//     }

//     return await location.getLocation();
//   }

//   Future<void> scheduleNotification() async {
//     var now = DateTime.now();
//     var androidDetails = new AndroidNotificationDetails(
//         'Channel ID', 'Waktu', 'Salah',
//         playSound: true,
//         sound: RawResourceAndroidNotificationSound('adhan'),
//         importance: Importance.Max);
//     var iOSDetails = new IOSNotificationDetails();
//     var generalNotif = new NotificationDetails(androidDetails, iOSDetails);
//     var sched = DateTime.now().add(Duration(seconds: 1));
//     if (DateFormat.jm().format(now) ==
//         DateFormat.jm().format(prayerTimes.fajr)) {
//       await flutterLocalNotificationsPlugin.schedule(
//           1,
//           'Salatul-Maghrib',
//           'Yā kaw taymanghud, Waktu na sin Sambahayang Maghrib.',
//           sched,
//           generalNotif);
//     }
//   }
// }
