// بسم الله الرحمن الرحيم
// O' Tuhan namu papag-barakata kamu in Application ini
// sarta tarbilanga kami dayng ha mga Mukhliseen. Ameen
import 'package:flutter/material.dart';
import 'package:tausug_tafseer/pages/Juz.dart';
import 'package:tausug_tafseer/pages/Masajid.dart';
import 'package:tausug_tafseer/pages/Pangindanan.dart';
import 'package:tausug_tafseer/pages/Qiblah.dart';
import 'package:tausug_tafseer/pages/Surah.dart';
import 'package:tausug_tafseer/style/Hex.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Widget appBarTitle = new Text("Tausug Quran");

  Icon actionIcon = new Icon(Icons.search);

  List<Widget> containers = [
    MgaSurah(),
    Juz(),
    Pangindanan(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: appBarTitle,
            titleSpacing: 0.0,
            leading: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                "images/logo_nav.png",
              ),
            ),
            actions: <Widget>[
              new IconButton(
                icon: actionIcon,
                onPressed: () {
                  setState(() {
                    if (this.actionIcon.icon == Icons.search) {
                      this.actionIcon = new Icon(Icons.close_rounded);
                      this.appBarTitle = new TextField(
                        style: new TextStyle(
                          color: Colors.white,
                        ),
                        decoration: new InputDecoration(
                            prefixIcon:
                                new Icon(Icons.search, color: Colors.white),
                            hintText: "Search...",
                            hintStyle: new TextStyle(color: Colors.white)),
                      );
                    } else {
                      this.actionIcon = new Icon(Icons.search);
                      this.appBarTitle = new Text("Tausug Quran");
                    }
                  });
                },
              ),
              MoreFeatures()
              // IconButton(
              //   icon: Icon(
              //     Icons.more_vert,
              //     color: Colors.white,
              //   ),
              //   onPressed: () {
              //     // do something
              //   },
              // ),
            ],
            bottom: TabBar(
              tabs: <Widget>[
                Tab(text: 'Surah'),
                Tab(text: 'Juz'),
                Tab(text: 'Pangindanan'),
              ],
            ),
          ),
          body: TabBarView(children: containers)),
    );
  }
}

enum MenuFeatures { Qiblah, Masajid, Waktu, About }

class MoreFeatures extends StatefulWidget {
  MoreFeatures({Key key}) : super(key: key);

  @override
  _MoreFeaturesState createState() => _MoreFeaturesState();
}

class _MoreFeaturesState extends State<MoreFeatures> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuFeatures>(
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<MenuFeatures>>[
          PopupMenuItem(
            child: Row(
              children: [
                Image.asset(
                  "images/Qiblah.png",
                  height: 30,
                  width: 30,
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                ),
                Text('Qiblah'),
              ],
            ),
            // Text('Qiblah'),
            value: MenuFeatures.Qiblah,
          ),
          PopupMenuItem(
            child: Row(
              children: [
                Icon(
                  Icons.watch_later_outlined,
                  color: Color(hexColor('#216353')),
                  size: 30,
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                ),
                Text('Waktu'),
              ],
            ),
            value: MenuFeatures.Waktu,
          ),
          PopupMenuItem(
            child: Row(
              children: [
                Image.asset(
                  "images/Masjid_Marker.png",
                  height: 30,
                  width: 30,
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                ),
                Text('Masājid'),
              ],
            ),
            value: MenuFeatures.Masajid,
          ),
          PopupMenuDivider(),
          PopupMenuItem(
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Color(hexColor('#216353')),
                  size: 30,
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                ),
                Text('About'),
              ],
            ),
            value: MenuFeatures.About,
          ),
        ];
      },
      onSelected: (result) {
        if (result == MenuFeatures.Qiblah) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Qiblah()),
          );
        } else if (result == MenuFeatures.Masajid) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Masajid()),
          );
        }
      },
    );
  }
}
