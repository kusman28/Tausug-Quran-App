// بسم الله الرحمن الرحيم
// O' Tuhan namu papag-barakata kamu in Application ini
// sarta tarbilanga kami dayng ha mga Mukhliseen. Ameen
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:tausug_tafseer/style/Hex.dart';
import 'package:tausug_tafseer/style/UI.dart';
import 'package:adhan/adhan.dart';

class Waktu extends StatefulWidget {
  @override
  _WaktuState createState() => _WaktuState();
}

class _WaktuState extends State<Waktu> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  // FlutterLocalNotificationsPlugin fltrNotification;
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
              CalculationMethod.muslim_world_league.getParameters());
          _salahNotif();
        });
      } else {
        setState(() {
          locationError = "Couldn't Get Your Location!";
        });
      }
    });
    // _fajrNotif();
    // _dhuhurNotif();
    // _asrNotif();
    // _maghribNotif();
    //
    // if (prayerTimes != null) {}
    super.initState();
  }

  void _salahNotif() async {
    // var wew = DateFormat.jm().format(prayerTimes.asr);
    // DateFormat('h:mm:ss').format(prayerTimes.fajr);
    // var subuh = new Time(prayerTimes.fajr.hour, prayerTimes.fajr.minute,
    //     prayerTimes.fajr.second);
    // var luhur = new Time(prayerTimes.dhuhr.hour, prayerTimes.dhuhr.minute,
    //     prayerTimes.dhuhr.second);
    // var asar = new Time(
    //     prayerTimes.asr.hour, prayerTimes.asr.minute, prayerTimes.asr.second);
    // var maghrib = new Time(prayerTimes.maghrib.hour, prayerTimes.maghrib.minute,
    //     prayerTimes.maghrib.second);
    // var isya = new Time(prayerTimes.isha.hour, prayerTimes.isha.minute,
    //     prayerTimes.isha.second);

    var androidDetails = new AndroidNotificationDetails('1', 'Waktu', 'Salah',
        playSound: true,
        sound: RawResourceAndroidNotificationSound('adhan'),
        importance: Importance.Max);
    var iOSDetails = new IOSNotificationDetails();
    var generalNotif = new NotificationDetails(androidDetails, iOSDetails);

    await flutterLocalNotificationsPlugin.showDailyAtTime(
        1,
        'Salatul-Fajr',
        'Yā kaw taymanghud, Waktu na sin Sambahayang Subuh.',
        new Time(prayerTimes.fajr.hour, prayerTimes.fajr.minute,
            prayerTimes.fajr.second),
        generalNotif);

    await flutterLocalNotificationsPlugin.showDailyAtTime(
        2,
        'Salatud-Dhuhr',
        'Yā kaw taymanghud, Waktu na sin Sambahayang Luhur.',
        new Time(prayerTimes.dhuhr.hour, prayerTimes.dhuhr.minute,
            prayerTimes.dhuhr.second),
        generalNotif);

    await flutterLocalNotificationsPlugin.showDailyAtTime(
        3,
        'Salatul-Asr',
        'Yā kaw taymanghud, Waktu na sin Sambahayang Asar.',
        new Time(prayerTimes.asr.hour, prayerTimes.asr.minute,
            prayerTimes.asr.second),
        generalNotif);

    await flutterLocalNotificationsPlugin.showDailyAtTime(
        4,
        'Salatul-Maghrib',
        'Yā kaw taymanghud, Waktu na sin Sambahayang Maghrib.',
        new Time(prayerTimes.maghrib.hour, prayerTimes.maghrib.minute,
            prayerTimes.maghrib.second),
        generalNotif);

    await flutterLocalNotificationsPlugin.showDailyAtTime(
        5,
        'Salatul-Isha',
        'Yā kaw taymanghud, Waktu na sin Sambahayang Isya.',
        new Time(prayerTimes.isha.hour, prayerTimes.isha.minute,
            prayerTimes.isha.second),
        generalNotif);
  }

  // void _dhuhurNotif() async {
  //   // var sched = DateTime.now().add(Duration(seconds: 1));
  //   var sched = new Time(11, 52, 0);
  //   var androidDetails = new AndroidNotificationDetails(
  //       'CHANNEL_ID 1', 'CHANNEL_NAME Waktu', 'CHANNEL_DESCRIPTION Salah',
  //       playSound: true,
  //       sound: RawResourceAndroidNotificationSound('adhan'),
  //       importance: Importance.Max);
  //   var iOSDetails = new IOSNotificationDetails();
  //   var generalNotif = new NotificationDetails(androidDetails, iOSDetails);
  //   await flutterLocalNotificationsPlugin.showDailyAtTime(
  //       1,
  //       'Salatud-Dhuhri',
  //       'Yā kaw taymanghud, Waktu na sin Sambahayang Luhur.',
  //       sched,
  //       generalNotif);
  // }

  // void _asrNotif() async {
  //   // var sched = DateTime.now().add(Duration(seconds: 1));
  //   var sched = new Time(15, 01, 0);
  //   var androidDetails = new AndroidNotificationDetails(
  //       'CHANNEL_ID 1', 'CHANNEL_NAME Waktu', 'CHANNEL_DESCRIPTION Salah',
  //       playSound: true,
  //       sound: RawResourceAndroidNotificationSound('adhan'),
  //       importance: Importance.Max);
  //   var iOSDetails = new IOSNotificationDetails();
  //   var generalNotif = new NotificationDetails(androidDetails, iOSDetails);
  //   await flutterLocalNotificationsPlugin.showDailyAtTime(
  //       1,
  //       'Salatul-Asr',
  //       'Yā kaw taymanghud, Waktu na sin Sambahayang Asar.',
  //       sched,
  //       generalNotif);
  // }

  // void _maghribNotif() async {
  //   // var sched = DateTime.now().add(Duration(seconds: 1));
  //   var sched = new Time(18, 00, 0);
  //   var androidDetails = new AndroidNotificationDetails(
  //       'CHANNEL_ID 1', 'CHANNEL_NAME Waktu', 'CHANNEL_DESCRIPTION Salah',
  //       playSound: true,
  //       sound: RawResourceAndroidNotificationSound('adhan'),
  //       importance: Importance.Max);
  //   var iOSDetails = new IOSNotificationDetails();
  //   var generalNotif = new NotificationDetails(androidDetails, iOSDetails);
  //   await flutterLocalNotificationsPlugin.showDailyAtTime(
  //       1,
  //       'Salatul-Maghrib',
  //       'Yā kaw taymanghud, Waktu na sin Sambahayang Maghrib.',
  //       sched,
  //       generalNotif);
  // }

  // void _ishaNotif() async {
  //   // var sched = DateTime.now().add(Duration(seconds: 1));
  //   var sched = new Time(19, 07, 0);
  //   var androidDetails = new AndroidNotificationDetails(
  //       'CHANNEL_ID 1', 'CHANNEL_NAME Waktu', 'CHANNEL_DESCRIPTION Salah',
  //       playSound: true,
  //       sound: RawResourceAndroidNotificationSound('adhan'),
  //       importance: Importance.Max);
  //   var iOSDetails = new IOSNotificationDetails();
  //   var generalNotif = new NotificationDetails(androidDetails, iOSDetails);
  //   await flutterLocalNotificationsPlugin.showDailyAtTime(
  //       1,
  //       'Salatul-Isha',
  //       'Yā kaw taymanghud, Waktu na sin Sambahayang Isya.',
  //       sched,
  //       generalNotif);
  // }

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

  // Future<void> scheduleNotification() async {
  //   var now = DateTime.now();
  //   var androidDetails = new AndroidNotificationDetails(
  //       'Channel ID', 'Waktu', 'Salah',
  //       playSound: true,
  //       sound: RawResourceAndroidNotificationSound('adhan'),
  //       importance: Importance.Max);
  //   var iOSDetails = new IOSNotificationDetails();
  //   var generalNotif = new NotificationDetails(androidDetails, iOSDetails);
  //   var sched = DateTime.now().add(Duration(seconds: 1));
  //   if (DateFormat.jm().format(now) ==
  //       DateFormat.jm().format(prayerTimes.fajr)) {
  //     await flutterLocalNotificationsPlugin.schedule(
  //         1,
  //         'Salatul-Maghrib',
  //         'Yā kaw taymanghud, Waktu na sin Sambahayang Maghrib.',
  //         sched,
  //         generalNotif);
  //   }
  // }

  // Future _showNotif() async {
  //   var androidDetails = new AndroidNotificationDetails(
  //       'Channel ID', 'Waktu', 'Salah',
  //       importance: Importance.Max);
  //   var iOSDetails = new IOSNotificationDetails();
  //   var generalNotif = new NotificationDetails(androidDetails, iOSDetails);
  //   var now = DateTime.now();
  //   var sched = DateTime.now().add(Duration(seconds: 5));
  //   flutterLocalNotificationsPlugin.schedule(
  //       1, 'Test', '123', sched, generalNotif);
  //   // await flutterLocalNotificationsPlugin.show(
  //   //     0, 'Sambahayang Isha', 'Waktu na sin Salatul-Isha.', generalNotif);
  //   // if (DateFormat.jm().format(now) ==
  //   //     DateFormat.jm().format(prayerTimes.isha)) {
  //   //   flutterLocalNotificationsPlugin.schedule(
  //   //       1, 'Test', '123', sched, generalNotif);
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    var ui = Provider.of<UI>(context);
    var now = DateTime.now();

    // if (DateFormat.jm().format(now) ==
    //     DateFormat.jm().format(prayerTimes.isha)) {
    //   flutterLocalNotificationsPlugin.schedule(
    //       1,
    //       'Salatul-Ishā',
    //       'Yā kaw taymanghud, Waktu na sin Sambahayang Ishā.',
    //       sched,
    //       generalNotif);
    // }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Waktu'),
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () => Navigator.pushReplacementNamed(context, '/Homepage'),
        ),
      ),
      body: (Builder(
        builder: (BuildContext context) {
          if (prayerTimes != null) {
            // DateFormat.jm().format(now) ==
            //         DateFormat.jm().format(prayerTimes.dhuhr)
            //     ? _dhuhurNotif()
            //     : DateFormat.jm().format(now) ==
            //             DateFormat.jm().format(prayerTimes.asr)
            //         ? _asrNotif()
            //         : DateFormat.jm().format(now) ==
            //                 DateFormat.jm().format(prayerTimes.maghrib)
            //             ? _maghribNotif()
            //             : DateFormat.jm().format(now) ==
            //                     DateFormat.jm().format(prayerTimes.isha)
            //                 ? _ishaNotif()
            //                 : null;
            return Column(
              children: [
                DateFormat.jm().format(now) ==
                        DateFormat.jm().format(prayerTimes.fajr)
                    ? Card(
                        color: Colors.greenAccent[100],
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(hexColor('#67c4ad')),
                            backgroundImage:
                                AssetImage('images/Waktu_Fajr.png'),
                          ),
                          title: Text(
                            'Fajr',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
                            ),
                          ),
                          subtitle: Text(
                            'الفجر',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
                              height: 0.5,
                            ),
                          ),
                          trailing: Text(
                            DateFormat.jm().format(prayerTimes.fajr),
                            style: TextStyle(
                              fontSize: ui.fontSize,
                            ),
                          ),
                        ),
                      )
                    : Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(hexColor('#67c4ad')),
                            backgroundImage:
                                AssetImage('images/Waktu_Fajr.png'),
                          ),
                          title: Text(
                            'Fajr',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
                            ),
                          ),
                          subtitle: Text(
                            'الفجر',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
                              height: 0.5,
                            ),
                          ),
                          trailing: Text(
                            DateFormat.jm().format(prayerTimes.fajr),
                            style: TextStyle(
                              fontSize: ui.fontSize,
                            ),
                          ),
                        ),
                      ),

                DateFormat.jm().format(now) ==
                        DateFormat.jm().format(prayerTimes.dhuhr)
                    ? Card(
                        color: Colors.greenAccent[100],
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(hexColor('#67c4ad')),
                            backgroundImage:
                                AssetImage('images/Waktu_Dhuhr.png'),
                          ),
                          title: Text(
                            'Dhuhr',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
                            ),
                          ),
                          subtitle: Text(
                            'الظهر',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
                              height: 0.5,
                            ),
                          ),
                          trailing: Text(
                            DateFormat.jm().format(prayerTimes.dhuhr),
                            style: TextStyle(
                              fontSize: ui.fontSize,
                            ),
                          ),
                        ),
                      )
                    : Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(hexColor('#67c4ad')),
                            backgroundImage:
                                AssetImage('images/Waktu_Dhuhr.png'),
                          ),
                          title: Text(
                            'Dhuhr',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
                            ),
                          ),
                          subtitle: Text(
                            'الظهر',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
                              height: 0.5,
                            ),
                          ),
                          trailing: Text(
                            DateFormat.jm().format(prayerTimes.dhuhr),
                            style: TextStyle(
                              fontSize: ui.fontSize,
                            ),
                          ),
                        ),
                      ),

                DateFormat.jm().format(now) ==
                        DateFormat.jm().format(prayerTimes.asr)
                    ? Card(
                        color: Colors.greenAccent[100],
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(hexColor('#67c4ad')),
                            backgroundImage: AssetImage('images/Waktu_Asr.png'),
                          ),
                          title: Text(
                            'Asr',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
                            ),
                          ),
                          subtitle: Text(
                            'العصر',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
                              height: 0.5,
                            ),
                          ),
                          trailing: Text(
                            DateFormat.jm().format(prayerTimes.asr),
                            style: TextStyle(
                              fontSize: ui.fontSize,
                            ),
                          ),
                        ),
                      )
                    : Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(hexColor('#67c4ad')),
                            backgroundImage: AssetImage('images/Waktu_Asr.png'),
                          ),
                          title: Text(
                            'Asr',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
                            ),
                          ),
                          subtitle: Text(
                            'العصر',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
                              height: 0.5,
                            ),
                          ),
                          trailing: Text(
                            DateFormat.jm().format(prayerTimes.asr),
                            style: TextStyle(
                              fontSize: ui.fontSize,
                            ),
                          ),
                        ),
                      ),
                DateFormat.jm().format(now) ==
                        DateFormat.jm().format(prayerTimes.maghrib)
                    ? Card(
                        color: Colors.greenAccent[100],
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(hexColor('#67c4ad')),
                            backgroundImage:
                                AssetImage('images/Waktu_Maghrib.png'),
                          ),
                          title: Text(
                            'Maghrib',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
                            ),
                          ),
                          subtitle: Text(
                            'المغرب',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
                              height: 0.5,
                            ),
                          ),
                          trailing: Text(
                            DateFormat.jm().format(prayerTimes.maghrib),
                            style: TextStyle(
                              fontSize: ui.fontSize,
                            ),
                          ),
                        ),
                      )
                    : Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(hexColor('#67c4ad')),
                            backgroundImage:
                                AssetImage('images/Waktu_Maghrib.png'),
                          ),
                          title: Text(
                            'Maghrib',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
                            ),
                          ),
                          subtitle: Text(
                            'المغرب',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
                              height: 0.5,
                            ),
                          ),
                          trailing: Text(
                            DateFormat.jm().format(prayerTimes.maghrib),
                            style: TextStyle(
                              fontSize: ui.fontSize,
                            ),
                          ),
                        ),
                      ),

                DateFormat.jm().format(now) ==
                        DateFormat.jm().format(prayerTimes.isha)
                    ? Card(
                        color: Colors.greenAccent[100],
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(hexColor('#67c4ad')),
                            backgroundImage:
                                AssetImage('images/Waktu_Isha.png'),
                          ),
                          title: Text(
                            '`Isha',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
                            ),
                          ),
                          subtitle: Text(
                            'العشاء',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
                              height: 0.5,
                            ),
                          ),
                          trailing: Text(
                            DateFormat.jm().format(prayerTimes.isha),
                            style: TextStyle(
                              fontSize: ui.fontSize,
                            ),
                          ),
                        ),
                      )
                    : Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(hexColor('#67c4ad')),
                            backgroundImage:
                                AssetImage('images/Waktu_Isha.png'),
                          ),
                          title: Text(
                            'Isha',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
                            ),
                          ),
                          subtitle: Text(
                            'العشاء',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
                              height: 0.5,
                            ),
                          ),
                          trailing: Text(
                            DateFormat.jm().format(prayerTimes.isha),
                            style: TextStyle(
                              fontSize: ui.fontSize,
                            ),
                          ),
                        ),
                      ),
                // RaisedButton(
                //   child: Text('Test123'),
                //   onPressed: () {},
                // )
                // Text(
                //   'Prayer Times for Today',
                //   textAlign: TextAlign.center,
                // ),
                // Text('Fajr Time: ' + DateFormat.jm().format(prayerTimes.fajr)),
                // Text('Sunrise Time: ' +
                //     DateFormat.jm().format(prayerTimes.sunrise)),
                // Text(
                //     'Dhuhr Time: ' + DateFormat.jm().format(prayerTimes.dhuhr)),
                // Text('Asr Time: ' + DateFormat.jm().format(prayerTimes.asr)),
                // Text('Maghrib Time: ' +
                //     DateFormat.jm().format(prayerTimes.maghrib)),
                // Text('Isha Time: ' + DateFormat.jm().format(prayerTimes.isha)),
              ],
            );
          }
          if (locationError != null) {
            return Text(locationError);
          }
          return Center(child: CircularProgressIndicator());
        },
      )),
    );
  }

  // void scheduleAlarm(
  //     DateTime scheduledNotificationDateTime, AlarmInfo alarmInfo) async {
  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     'alarm_notif',
  //     'alarm_notif',
  //     'Channel for Alarm notification',
  //     icon: 'logo_nav',
  //     sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
  //     largeIcon: DrawableResourceAndroidBitmap('logo_nav'),
  //   );

  //   var iOSPlatformChannelSpecifics = IOSNotificationDetails(
  //       sound: 'a_long_cold_sting.wav',
  //       presentAlert: true,
  //       presentBadge: true,
  //       presentSound: true);
  //   var platformChannelSpecifics = NotificationDetails(
  //       androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

  //   await flutterLocalNotificationsPlugin.schedule(0, 'Office', alarmInfo.title,
  //       scheduledNotificationDateTime, platformChannelSpecifics);
  // }
  //
  Future notificationSelected(String payload) async {}
}
