// بسم الله الرحمن الرحيم
// O' Tuhan namu papag-barakata kamu in Application ini
// sarta tarbilanga kami dayng ha mga Mukhliseen. Ameen
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tausug_tafseer/pages/Qiblah.dart';
import 'package:tausug_tafseer/pages/TopBarNavigation.dart';
import 'package:tausug_tafseer/style/Hex.dart';
import 'package:provider/provider.dart';
import 'package:tausug_tafseer/style/UI.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

const String SETTINGS_BOX = "settings";
const String API_BOX = "api_data";
const String FAVORITE_BOX = "favorites_box";

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  // Hive DB
  await Hive.initFlutter();
  await Hive.openBox(SETTINGS_BOX);
  await Hive.openBox(API_BOX);
  await Hive.openBox(FAVORITE_BOX);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UI()),
  ], child: MyApp()));
  WidgetsFlutterBinding.ensureInitialized();

  // Local Notification
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
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );
    return MaterialApp(
      title: 'Tausug Quran',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Color(hexColor('#216353')),
      ),
      home: new MainScreen(),
      initialRoute: '/',
      routes: {
        '/Homepage': (context) => Homepage(),
        '/Qiblah': (context) => Qiblah()
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(Hive.box(SETTINGS_BOX).get("welcome_shown"));
    return ValueListenableBuilder(
      valueListenable: Hive.box(SETTINGS_BOX).listenable(),
      builder: (context, box, child) =>
          box.get('welcome_shown', defaultValue: false)
              ? SplashScreen()
              : OnBoardingPage(),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SplashScreen()),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('images/$assetName.jpg', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 28.0, fontWeight: FontWeight.w700, fontFamily: 'Arabic'),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Tausug Quran",
          body: "Maana sin Quran Mahamulliya ha Bahasa Sug.",
          image: Center(
            child: Image.asset("images/logo_nav.png", height: 175.0),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Qiblah",
          body: "Ingatun natu' bang dapit pakain in Qiblah.",
          image: _buildImage('slider_4'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Masajid",
          body: "Ingatun natu' in mga kamasjiran masuuk pa Qawman.",
          image: _buildImage('slider_1'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Al-Quran Al-Kareem",
          body: "Bassahun natu' in Quran Mahamulliya sarta iban maana niya.",
          image: _buildImage('slider_2'),
          footer: RaisedButton(
            onPressed: () {
              introKey.currentState?.animateScroll(0);
            },
            child: const Text(
              'Panagnaan',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3.0),
            ),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Waktu",
          body: "Ingatun natu' in mga waktu sin Sambahayang.",
          // bodyWidget: Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: const [
          //     Text("Ingatun natu in Waktu sin mga Sambahayang.",
          //         style: bodyStyle),
          //     Icon(Icons.edit),
          //     Text(" to edit a post", style: bodyStyle),
          //   ],
          // ),
          image: _buildImage('slider_3'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: GestureDetector(
          onTap: () async {
            var box = Hive.box(SETTINGS_BOX);
            box.put("welcome_shown", true);
          },
          child: const Text('Done',
              style: TextStyle(fontWeight: FontWeight.w600))),
      dotsDecorator: const DotsDecorator(
        size: Size(7.0, 7.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
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
                  'Maana sin',
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
