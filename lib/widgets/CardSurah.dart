// بسم الله الرحمن الرحيم
// O' Tuhan namu papag-barakata kamu in Application ini
// sarta tarbilanga kami dayng ha mga Mukhliseen. Ameen
import 'package:flutter/material.dart';
import 'package:tausug_tafseer/models/Surah.dart';
import 'package:tausug_tafseer/style/Hex.dart';
import 'package:tausug_tafseer/style/Style.dart';

class CardSurah extends StatelessWidget {
  CardSurah(
      {this.title,
      this.subtitle,
      this.surah,
      this.surahImage,
      this.basmalahImage,
      this.tafsir,
      this.ayah,
      this.arabic,
      this.onTap});

  final String title,
      subtitle,
      surah,
      surahImage,
      basmalahImage,
      tafsir,
      ayah,
      arabic;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: onTap,
          contentPadding: EdgeInsets.fromLTRB(13, 3, 13, 3),
          title: new Text(
            subtitle,
            style: TextStyle(
                fontSize: 17,
                color: Color(
                  hexColor('#216353'),
                )),
          ),
          leading: CircleAvatar(
            foregroundColor: Color(hexColor('#216353')),
            backgroundColor: Colors.white54,
            backgroundImage: AssetImage('images/separator.png'),
            child: Text(surah, style: TextStyle(fontSize: 12.0)),
          ),
          trailing: new Image.asset(
            surahImage,
            width: 100,
          ),
          // trailing: new Text(arabic, textDirection: TextDirection.rtl,
          // style: TextStyle(fontFamily: 'KFGQPC Uthman Taha Naskh', fontSize: 22.0),),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                ayah + ' Ayat',
                style: TextStyle(color: Color(hexColor('#222831'))),
                // textAlign: TextAlign.left,
              ),
              // new Text(tafsir),
            ],
          ),
        ),
        Divider()
      ],
    );

    // return Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //   child: Card(
    //       elevation: 0.0,
    //       child: Container(
    //         padding: EdgeInsets.all(12.0),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             ListTile(
    //               onTap: onTap,
    //               title: Padding(
    //                 padding: const EdgeInsets.only(bottom: 8.0),
    //                 child: Text(
    //                   title,
    //                   style: AppStyle.title,
    //                 ),
    //               ),
    //               subtitle: Text(subtitle, style: AppStyle.subtitle),
    //               trailing: Icon(Icons.keyboard_arrow_right),
    //             ),
    //             AppStyle.spaceH5,
    //             Padding(
    //               padding: const EdgeInsets.all(12.0),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                 children: <Widget>[
    //                   Column(
    //                     children: <Widget>[
    //                       Text('Surat Ke', style: AppStyle.end2subtitle),
    //                       AppStyle.spaceH5,
    //                       Text(
    //                         surah,
    //                         style: TextStyle(fontWeight: FontWeight.bold),
    //                       ),
    //                     ],
    //                   ),
    //                   Column(
    //                     children: <Widget>[
    //                       Text('Ayat', style: AppStyle.end2subtitle),
    //                       AppStyle.spaceH5,
    //                       Text(
    //                         ayah,
    //                         style: TextStyle(fontWeight: FontWeight.bold),
    //                       ),
    //                     ],
    //                   ),
    //                   Column(
    //                     children: <Widget>[
    //                       Text('Arabic', style: AppStyle.end2subtitle),
    //                       AppStyle.spaceH5,
    //                       Text(
    //                         arabic,
    //                         style: TextStyle(fontWeight: FontWeight.bold),
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       )),
    // );
  }
}
