// بسم الله الرحمن الرحيم
// O' Tuhan namu papag-barakata kamu in Application ini
// sarta tarbilanga kami dayng ha mga Mukhliseen. Ameen
import 'package:flutter/material.dart';
import 'package:tausug_tafseer/style/Hex.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  const About({Key key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('About'),
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, '/Homepage'),
          ),
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.only(top: 100),
            padding: EdgeInsets.all(25),
            child: Column(
              children: <Widget>[
                Image.asset('images/developer.png'),
                Text(
                  "Under Development",
                  style: TextStyle(
                    color: Color(hexColor('#216353')),
                    fontWeight: FontWeight.normal,
                    fontSize: 25,
                  ),
                  // textAlign: TextAlign.center,
                ),
                Text(
                  // "Masi masi pa in pag-encode sin kami iban pag-butang mga functions kalagihan.\nMura murahan dumagbus in maksud natu ini.\nLapayun niyu mayan kami ha dua'a niyu. Ameen\n\n#TausugQuran",
                  "\nIn App ini masi-masi pa in pag-hinang sin kami.\nDayng ha sabab yadtu awn pa dayng ha mga kaybanan Functions di' pa mausal.\n",
                  style: TextStyle(
                    color: Colors.black,
                    // fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  // textAlign: TextAlign.left,
                ),
                // new InkWell(
                //     child: new Text(
                //       'Facebook',
                //       style: TextStyle(
                //           decoration: TextDecoration.underline,
                //           color: Colors.blueAccent),
                //     ),
                //     onTap: () => launch('https://www.facebook.com/TausugQuran313'))
                new RaisedButton(
                  color: Colors.blueAccent,
                  onPressed: _launchURL,
                  child: new Text(
                    'Facebook',
                    style: TextStyle(
                      color: Colors.white,
                      // fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

_launchURL() async {
  const url = 'https://www.facebook.com/TausugQuran313';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
