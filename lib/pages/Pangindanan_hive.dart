// بسم الله الرحمن الرحيم
// O' Tuhan namu papag-barakata kamu in Application ini
// sarta tarbilanga kami dayng ha mga Mukhliseen. Ameen
import 'package:flutter/material.dart';
import 'package:tausug_tafseer/controllers/DBHelper.dart';
import 'package:tausug_tafseer/controllers/Pangindanan.dart';
import 'package:provider/provider.dart';
import 'package:tausug_tafseer/style/UI.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const String FAVORITE_BOX = "favorites_box";

class Pangindanan extends StatefulWidget {
  @override
  _PangindananState createState() => _PangindananState();
}

class _PangindananState extends State<Pangindanan> {
  List<Bookmarks> _pangindanan;

  @override
  void initState() {
    super.initState();
    _pangindanan = [];
  }

  @override
  Widget build(BuildContext context) {
    var ui = Provider.of<UI>(context);
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: Hive.box(FAVORITE_BOX).listenable(),
          // stream: myDatabase.getEmployees().asStream(),
          builder: (context, box, child) {
            List posts = List.from(box.values);
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: <Widget>[
                // Text("This is a home page"),
                ...posts.map((p) => ListTile(
                      title: Text(
                        p,
                        style: TextStyle(
                          fontFamily: 'Arabic',
                          fontSize: ui.fontSize,
                          height: 1.0,
                        ),
                      ),
                      // subtitle: Text(p.replaceAll("\n", p)),
                      // trailing: IconButton(
                      //   icon: Icon(Icons.delete),
                      //   onPressed: () {
                      //     box.delete(p.id);
                      //   },
                      // ),
                      onTap: () {
                        //
                      },
                    )),
              ],
            );
          }),
    );
  }
}
