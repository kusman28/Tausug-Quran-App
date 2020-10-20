// بسم الله الرحمن الرحيم
// O' Tuhan namu papag-barakata kamu in Application ini
// sarta tarbilanga kami dayng ha mga Mukhliseen. Ameen
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tausug_tafseer/controllers/Surah.dart';
import 'package:tausug_tafseer/models/SurahTafseer.dart';
import 'package:tausug_tafseer/style/Hex.dart';
import 'package:tausug_tafseer/style/Style.dart';
import 'package:tausug_tafseer/style/UI.dart';

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
                        padding: const EdgeInsets.fromLTRB(18, 10, 15, 10),
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
                              title: SelectableText(
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
                                  SelectableText(
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
                                IconButton(
                                    icon: new Icon(Icons.content_copy),
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
                                        content: Text('Tafseer Copied'),
                                        backgroundColor:
                                            Color(hexColor('#216353')),
                                      ));
                                    }),
                                Text(
                                  '|',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                IconButton(
                                  icon: new Icon(Icons.bookmark_border),
                                  onPressed: () {},
                                ),
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
}
