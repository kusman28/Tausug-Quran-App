// بسم الله الرحمن الرحيم
// O' Tuhan namu papag-barakata kamu in Application ini
// sarta tarbilanga kami dayng ha mga Mukhliseen. Ameen
import 'package:flutter/material.dart';

class Juz extends StatefulWidget {
  @override
  _JuzState createState() => _JuzState();
}

class _JuzState extends State<Juz> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 100),
        child: Column(
          children: <Widget>[
            Text(
              "Ha susungun...",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 25,
              ),
              // textAlign: TextAlign.center,
            ),
            Text(
              "Masi masi pa in pag-encode sin kami iban pag-butang mga functions kalagihan.\nMura murahan dumagbus in maksud natu ini.\nLapayun niyu mayan kami ha dua'a niyu. Ameen\n\n#TausugQuran",
              style: TextStyle(
                color: Colors.black,
                // fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
