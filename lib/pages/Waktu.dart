// بسم الله الرحمن الرحيم
// O' Tuhan namu papag-barakata kamu in Application ini
// sarta tarbilanga kami dayng ha mga Mukhliseen. Ameen
import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:tausug_tafseer/style/Hex.dart';
import 'package:tausug_tafseer/style/UI.dart';

class Waktu extends StatefulWidget {
  @override
  _WaktuState createState() => _WaktuState();
}

class _WaktuState extends State<Waktu> {
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
    var ui = Provider.of<UI>(context);
    var now = DateTime.now();
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
                            'Fajr / الفجر',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
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
                            'Fajr / الفجر',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
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
                            'Dhuhr / الظهر',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
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
                            'Dhuhr / الظهر',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
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
                            'Asr / العصر',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
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
                            'Asr / العصر',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
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
                            'Maghrib / المغرب',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
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
                            'Maghrib / المغرب',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
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
                            'Isha / العشاء',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
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
                            'Isha / العشاء',
                            style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: ui.fontSize,
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
          return CircularProgressIndicator();
        },
      )),
    );
  }
}
