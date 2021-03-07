// بسم الله الرحمن الرحيم
// O' Tuhan namu papag-barakata kamu in Application ini
// sarta tarbilanga kami dayng ha mga Mukhliseen. Ameen
import 'package:flutter/material.dart';
import 'package:tausug_tafseer/models/Surah.dart';
import 'package:tausug_tafseer/pages/SurahTafseer.dart';
import 'package:tausug_tafseer/widgets/CardSurah.dart';
import 'package:tausug_tafseer/controllers/Surah.dart';
import 'package:pk_skeleton/pk_skeleton.dart';

class MgaSurah extends StatefulWidget {
  @override
  _MgaSurahState createState() => _MgaSurahState();
}

class _MgaSurahState extends State<MgaSurah> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Surah>>(
      future: ServiceData().loadSurah(),
      builder: (c, snapshot) {
        return snapshot.hasData
            ? ListView(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                children: snapshot.data
                    .map((data) => CardSurah(
                          title: data.latin,
                          subtitle: data.translation,
                          surahImage: data.image,
                          basmalahImage: data.basmalah,
                          tafsir: data.tafsir,
                          surah: data.index.toString(),
                          ayah: data.ayahCount.toString(),
                          arabic: data.arabic.toString(),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SurahTafseer(
                                          detail: data.latin,
                                          basmalah: data.basmalah,
                                          tafsir: data.tafsir,
                                          index: data.index,
                                        )));
                          },
                        ))
                    .toList())
            : PKCardListSkeleton(
                isCircularImage: true,
                isBottomLinesActive: true,
                length: 10,
              );
      },
    );
  }
}
