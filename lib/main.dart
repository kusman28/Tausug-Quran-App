// بسم الله الرحمن الرحيم
// O' Tuhan namu papag-barakata kamu in Application ini
// sarta tarbilanga kami dayng ha mga Mukhliseen. Ameen
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tausug_tafseer/database/database.dart';
import 'package:tausug_tafseer/pages/TopBarNavigation.dart';
import 'package:tausug_tafseer/style/Hex.dart';
import 'package:provider/provider.dart';
import 'package:tausug_tafseer/style/UI.dart';

import 'dao/FavoriteDAO.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database =
      await $FloorAppDatabase.databaseBuilder('bookmarks.db').build();
  final dao = database.favoriteDAO;
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UI()),
  ], child: MyApp(dao: dao)));
}

class MyApp extends StatelessWidget {
  final FavoriteDAO dao;
  MyApp({this.dao});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
