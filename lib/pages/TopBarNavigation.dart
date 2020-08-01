// بسم الله الرحمن الرحيم
// O' Tuhan namu papag-barakata kamu in Application ini
// sarta tarbilanga kami dayng ha mga Mukhliseen. Ameen
import 'package:flutter/material.dart';
import 'package:tausug_tafseer/pages/Juz.dart';
import 'package:tausug_tafseer/pages/Pangindanan.dart';
import 'package:tausug_tafseer/pages/Surah.dart';

class Homepage extends StatelessWidget {

  List<Widget> containers = [
    Surah(),
    Juz(),
    Pangindanan(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tausug Tafseer'),
          bottom: TabBar(tabs: 
            <Widget>[
              Tab(text: 'Surah'),
              Tab(text: 'Juz'),
              Tab(text: 'Pangindanan'),
            ],
          ),
        ),
        body: TabBarView(children: containers)
      ),
    );
  }
}