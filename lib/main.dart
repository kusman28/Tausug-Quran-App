// بسم الله الرحمن الرحيم
// O' Tuhan namu papag-barakata kamu in Application ini
// sarta tarbilanga kami dayng ha mga Mukhliseen. Ameen
import 'dart:async';

import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:tausug_tafseer/pages/Qiblah.dart';
import 'package:tausug_tafseer/pages/TopBarNavigation.dart';
import 'package:tausug_tafseer/style/Hex.dart';
import 'package:provider/provider.dart';
import 'package:tausug_tafseer/style/UI.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UI()),
  ], child: MyApp()));
  WidgetsFlutterBinding.ensureInitialized();
  var initializationSettingsAndroid = AndroidInitializationSettings('logo_nav');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final location = new Location();

  String locationError;

  PrayerTimes prayerTimes;

  @override
  void initState() {
    getLocationData().then((locationData) {
      if (!mounted) {
        return;
      }
      if (locationData != null) {
        setState(() {
          prayerTimes = PrayerTimes(
              Coordinates(locationData.latitude, locationData.longitude),
              DateComponents.from(DateTime.now()),
              CalculationMethod.karachi.getParameters());
        });
      } else {
        setState(() {
          locationError = "Couldn't Get Your Location!";
        });
      }
    });

    super.initState();
  }

  Future<LocationData> getLocationData() async {
    var _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    var _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();

    var androidDetails = new AndroidNotificationDetails(
        'Channel ID', 'Waktu', 'Salah',
        playSound: true,
        sound: RawResourceAndroidNotificationSound('adhan'),
        priority: Priority.High,
        importance: Importance.Max);
    var iOSDetails = new IOSNotificationDetails();
    var generalNotif = new NotificationDetails(androidDetails, iOSDetails);
    var sched = DateTime.now().add(Duration(seconds: 1));
    if (prayerTimes != null) {
      if (DateFormat.jm().format(now) ==
          DateFormat.jm().format(prayerTimes.fajr)) {
        flutterLocalNotificationsPlugin.schedule(
            1,
            'Salatul-Fajr',
            'Yā kaw taymanghud, Waktu na sin Sambahayang Fajr.',
            sched,
            generalNotif);
      }

      if (DateFormat.jm().format(now) ==
          DateFormat.jm().format(prayerTimes.dhuhr)) {
        flutterLocalNotificationsPlugin.schedule(
            1,
            'Salatud-Dhuhr',
            'Yā kaw taymanghud, Waktu na sin Sambahayang Dhuhr.',
            sched,
            generalNotif);
      }

      if (DateFormat.jm().format(now) ==
          DateFormat.jm().format(prayerTimes.asr)) {
        flutterLocalNotificationsPlugin.schedule(
            1,
            'Salatul-Asr',
            'Yā kaw taymanghud, Waktu na sin Sambahayang Asr.',
            sched,
            generalNotif);
      }

      if (DateFormat.jm().format(now) ==
          DateFormat.jm().format(prayerTimes.maghrib)) {
        flutterLocalNotificationsPlugin.schedule(
            1,
            'Salatul-Maghrib',
            'Yā kaw taymanghud, Waktu na sin Sambahayang Maghrib.',
            sched,
            generalNotif);
      }

      if (DateFormat.jm().format(now) ==
          DateFormat.jm().format(prayerTimes.isha)) {
        flutterLocalNotificationsPlugin.schedule(
            1,
            'Salatul-Ishā',
            'Yā kaw taymanghud, Waktu na sin Sambahayang Ishā.',
            sched,
            generalNotif);
      }
    }
    return MaterialApp(
      title: 'Tausug Quran',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Color(hexColor('#216353')),
      ),
      home: new SplashScreen(),
      initialRoute: '/',
      routes: {
        '/Homepage': (context) => Homepage(),
        '/Qiblah': (context) => Qiblah()
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/Homepage');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(hexColor('#216353')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset('images/logo_nav.png'),
                ),
                Text(
                  'Tausug Quran\n\n\n\n\n',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 21.0,
                    fontFamily: 'Arabic',
                  ),
                ),
                Text(
                  'Tafseer Maana sin',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontFamily: 'Arabic',
                  ),
                ),
                Text(
                  'Quran Mahamulliya',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arabic',
                  ),
                ),
                Text(
                  'ha Bahasa Sug',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontFamily: 'Arabic',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
