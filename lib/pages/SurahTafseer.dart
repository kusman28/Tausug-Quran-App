// بسم الله الرحمن الرحيم
// O' Tuhan namu papag-barakata kamu in Application ini
// sarta tarbilanga kami dayng ha mga Mukhliseen. Ameen
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tausug_tafseer/controllers/DBHelper.dart';
import 'package:tausug_tafseer/controllers/Pangindanan.dart';
import 'package:tausug_tafseer/controllers/Surah.dart';
import 'package:tausug_tafseer/models/SurahTafseer.dart';
import 'package:tausug_tafseer/style/Hex.dart';
import 'package:tausug_tafseer/style/Style.dart';
import 'package:tausug_tafseer/style/UI.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SurahTafseer extends StatefulWidget {
  final tafsir, basmalah, detail, index;
  SurahTafseer(
      {Key key, @required this.tafsir, this.basmalah, this.detail, this.index})
      : super(key: key);

  @override
  _SurahTafseerState createState() => _SurahTafseerState();
}

class _SurahTafseerState extends State<SurahTafseer> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    var ui = Provider.of<UI>(context);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          title: Column(
            children: <Widget>[
              Text(widget.detail),
              Text(
                widget.tafsir,
                style:
                    TextStyle(fontSize: 13, color: Color(hexColor('d9e4dd'))),
              )
            ],
          ),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Settings()));
              },
            )
          ],
        ),
        body: FutureBuilder<AllSurah>(
          future: ServiceData().loadSurahTafseer(widget.index),
          builder: (c, snapshot) {
            // var myDatabase = Provider.of<DBHelper>(context);
            return snapshot.hasData
                ? ListView.separated(
                    // physics: AlwaysScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => Divider(
                          color: Colors.grey,
                        ),
                    itemCount: snapshot.data.text.length,
                    itemBuilder: (BuildContext c, int i) {
                      String key = snapshot.data.text.keys.elementAt(i);
                      return Padding(
                        // padding: const EdgeInsets.fromLTRB(18, 10, 15, 10),
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                foregroundColor: Color(hexColor('#216353')),
                                backgroundColor: Colors.white54,
                                backgroundImage:
                                    AssetImage('images/separator.png'),
                                child: Text(
                                    snapshot.data.text.keys.elementAt(i),
                                    style: TextStyle(fontSize: 12.0)),
                              ),
                              title: Text(
                                '${snapshot.data.text[key]}',
                                // textAlign: TextAlign.end,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontFamily: 'KFGQPC Uthman Taha Naskh',
                                  fontSize: ui.fontSize,
                                  height: 1.5,
                                ),
                              ),
                              // onTap: (){
                              //   Clipboard.setData(new ClipboardData(text: '${snapshot.data.text[key]}'));
                              //   Scaffold.of(context).showSnackBar(SnackBar
                              //     (content: Text('text copied')));
                              // }
                            ),
                            if (ui.tarjuma)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  AppStyle.spaceH5,
                                  Text(
                                    snapshot.data.translations.id.text[key],
                                    style: TextStyle(
                                      fontSize: ui.fontSizetext,
                                    ),
                                  ),
                                  AppStyle.spaceH10,
                                ],
                              ),
                            AppStyle.spaceH10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                // IconButton(
                                //   icon: new Icon(Icons.info_outline),
                                //   color: Colors.grey,
                                //   onPressed: () =>
                                //       _onButtonPressed(snapshot, key),
                                // ),
                                // Text(
                                //   '|',
                                //   style: TextStyle(color: Colors.grey[300]),
                                // ),
                                IconButton(
                                    icon: new Icon(Icons.content_copy),
                                    color: Colors.grey,
                                    onPressed: () {
                                      Clipboard.setData(new ClipboardData(
                                          text: '${snapshot.data.text[key]}' +
                                              '\n \n'
                                                  '${snapshot.data.translations.id.text[key]}' +
                                              '\n'
                                                  '[${snapshot.data.nameLatin}' +
                                              ' : '
                                                  '${snapshot.data.text.keys.elementAt(i)}]' +
                                              '\n \n' +
                                              '#TausugQuran'));
                                      _scaffoldKey.currentState
                                          .showSnackBar(SnackBar(
                                        content: Text('Tafsir Copied'),
                                        backgroundColor:
                                            Color(hexColor('#373a40')),
                                        duration: Duration(seconds: 1),
                                      ));
                                    }),
                                Text(
                                  '|',
                                  style: TextStyle(color: Colors.grey[300]),
                                ),
                                IconButton(
                                    // icon: new Icon(Icons.bookmark_border),
                                    icon: Icon(
                                      _selectedIndex != null &&
                                              _selectedIndex ==
                                                  snapshot.data.translations.id
                                                      .text[key]
                                          ? Icons.bookmark
                                          : Icons.bookmark_border,
                                      color: _selectedIndex != null &&
                                              _selectedIndex ==
                                                  snapshot.data.translations.id
                                                      .text[key]
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                    onPressed: () {
                                      _onSelected(snapshot, key);
                                      _scaffoldKey.currentState
                                          .showSnackBar(SnackBar(
                                        content: Text('Added to Pangindanan'),
                                        backgroundColor:
                                            Color(hexColor('#373a40')),
                                        duration: Duration(seconds: 1),
                                      ));
                                    }),
                              ],
                            ),
                          ],
                        ),
                      );
                    })
                : Center(child: CircularProgressIndicator());
          },
        ));
  }

  String _selectedIndex;
  void _onSelected(snapshot, key) {
    _selectedIndex = snapshot.data.text[key] +
        '\n' +
        snapshot.data.translations.id.text[key];
    Bookmarks e = Bookmarks(null, _selectedIndex);
    DBHelper.ddb.save(e);
    print(_selectedIndex);
    // setState(() {
    // });
  }

  void _onButtonPressed(snapshot, key) {
    // String key = snapshot.data.text.keys.elementAt(i);
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 250,
            child: Container(
              child: _buildButtomNav(snapshot, key),
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(10),
                      topRight: const Radius.circular(10))),
            ),
          );
        });
  }

  ListView _buildButtomNav(snapshot, key) {
    return ListView(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.all(20),
          leading: Icon(Icons.info),
          title: Text(
              'Parsawahan:\n' + snapshot.data.tafsir.id.parsawahan.text[key]),
          // onTap: () => _selectItem('In shaa Allah'),
        )
      ],
    );
  }
}
