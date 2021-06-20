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
import 'package:flutter_search_bar/flutter_search_bar.dart';
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
  SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController controller = new TextEditingController();
  List<SurahTafseer> _list = [];
  List<SurahTafseer> _search = [];
  var loading = false;

  onSearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _list.forEach((f) {
      if (f.tafsir.contains(text) || f.detail.toString().contains(text))
        _search.add(f);
    });

    setState(() {});
  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: Column(
          children: <Widget>[
            Text(widget.detail),
            Text(
              widget.tafsir,
              style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Arabic',
                  color: Color(hexColor('d9e4dd'))),
            )
          ],
        ),
        actions: [searchBar.getSearchAction(context)]);
  }

  void onSubmitted(String value) {
    setState(() => _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text('You wrote $value!'))));
  }

  _SurahTafseerState() {
    searchBar = new SearchBar(
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        onCleared: () {
          print("cleared");
        },
        onClosed: () {
          print("closed");
        });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    var ui = Provider.of<UI>(context);
    return Scaffold(
        key: _scaffoldKey,
        appBar: searchBar.build(context),
        // AppBar(
        //   leading: IconButton(
        //     icon: Icon(Icons.keyboard_backspace),
        //     onPressed: () => Navigator.of(context).pop(),
        //   ),
        //   centerTitle: true,
        //   title: Column(
        //     children: <Widget>[
        //       Text(widget.detail),
        //       Text(
        //         widget.tafsir,
        //         style: TextStyle(
        //             fontSize: 13,
        //             fontFamily: 'Arabic',
        //             color: Color(hexColor('d9e4dd'))),
        //       )
        //     ],
        //   ),
        //   elevation: 0.0,
        //   actions: <Widget>[
        //     IconButton(
        //       icon: Icon(Icons.search),
        //       onPressed: () {
        //         // Navigator.push(context,
        //         //     MaterialPageRoute(builder: (context) => Settings()));
        //       },
        //     )
        //   ],
        // ),
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                      child: _search.length != 0 || controller.text.isNotEmpty
                          ? ListView.builder(
                              itemCount: _search.length,
                              itemBuilder: (context, i) {
                                final b = _search[i];
                                return Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          b.tafsir,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0),
                                        ),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                        Text(b.detail),
                                      ],
                                    ));
                              },
                            )
                          : FutureBuilder<AllSurah>(
                              future:
                                  ServiceData().loadSurahTafseer(widget.index),
                              builder: (c, snapshot) {
                                // var myDatabase = Provider.of<DBHelper>(context);

                                var surah = snapshot.data;
                                // new Image.asset('images/basmalah.png');
                                // Container(
                                //     height: 40,
                                //     color: Colors.deepOrange,
                                //     child: Center(
                                //       child: Text(
                                //         'Header',
                                //         style: TextStyle(color: Colors.white, fontSize: 16),
                                //       ),
                                //     ),
                                //   );
                                return ListView(children: <Widget>[
                                  Container(
                                    height: 50,
                                    color: Colors.grey[800],
                                    // color: Color(hexColor('#216353')),
                                    // decoration: BoxDecoration(
                                    //     border: Border.all(
                                    //         width: 2, color: Color(hexColor('#216353')))),
                                    // child: Center(child: Image.asset(snapshot.data.basmalah)),
                                    child: surah?.nameLatin == "Al-Fatihah" ||
                                            surah?.nameLatin == "At-Taubah"
                                        ? Center(
                                            child: Text(
                                            'أعوذُ بِٱللَّهِ مِنَ ٱلشَّيۡطَٰنِ ٱلرَّجِيمِ',
                                            style: TextStyle(
                                              fontFamily: 'Arabic',
                                              fontSize: ui.fontSize,
                                              color: Colors.white,
                                              height: 1.0,
                                            ),
                                          ))
                                        : Center(
                                            child: Text(
                                            'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيم',
                                            style: TextStyle(
                                              fontFamily: 'Arabic',
                                              fontSize: ui.fontSize,
                                              color: Colors.white,
                                              height: 1.0,
                                            ),
                                          )),
                                  ),
                                  snapshot.hasData
                                      ? ListView.separated(
                                          shrinkWrap: true,
                                          physics: ScrollPhysics(),
                                          separatorBuilder: (context, index) =>
                                              Divider(
                                                color: Colors.grey,
                                              ),
                                          itemCount: snapshot.data.text.length,
                                          itemBuilder: (BuildContext c, int i) {
                                            String key = snapshot.data.text.keys
                                                .elementAt(i);

                                            bool _isFavorited = true;
                                            void _toggleFavorite() {
                                              setState(() {
                                                if (_isFavorited) {
                                                  Bookmarks e = Bookmarks(null,
                                                      snapshot.data.text[key]);
                                                  DBHelper.ddb.save(e);
                                                  print(i);
                                                  _isFavorited = false;
                                                } else {
                                                  // DBHelper.ddb.delete(ayat.id);
                                                  print(i);
                                                  _isFavorited = true;
                                                }
                                              });
                                            }

                                            return Padding(
                                              // padding: const EdgeInsets.fromLTRB(18, 10, 15, 10),
                                              padding: const EdgeInsets.all(15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  ListTile(
                                                    leading: CircleAvatar(
                                                      foregroundColor: Color(
                                                          hexColor('#216353')),
                                                      backgroundColor:
                                                          Colors.white54,
                                                      backgroundImage: AssetImage(
                                                          'images/separator.png'),
                                                      child: Text(
                                                          snapshot
                                                              .data.text.keys
                                                              .elementAt(i),
                                                          style: TextStyle(
                                                              fontSize: 12.0)),
                                                    ),
                                                    title: Text(
                                                      '${snapshot.data.text[key]}',
                                                      // textAlign: TextAlign.end,
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'KFGQPC Uthman Taha Naskh',
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
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        AppStyle.spaceH5,
                                                        Text(
                                                          snapshot
                                                              .data
                                                              .translations
                                                              .id
                                                              .text[key],
                                                          style: TextStyle(
                                                            fontSize:
                                                                ui.fontSizetext,
                                                          ),
                                                        ),
                                                        AppStyle.spaceH10,
                                                      ],
                                                    ),
                                                  AppStyle.spaceH10,
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      IconButton(
                                                        icon: new Icon(
                                                            Icons.info_outline),
                                                        color: Colors.grey,
                                                        onPressed: () =>
                                                            _onButtonPressed(
                                                                snapshot, key),
                                                      ),
                                                      Text(
                                                        '|',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[300]),
                                                      ),

                                                      IconButton(
                                                          icon: new Icon(Icons
                                                              .content_copy),
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
                                                            _scaffoldKey
                                                                .currentState
                                                                .showSnackBar(
                                                                    SnackBar(
                                                              content: Text(
                                                                  'Tafsir Copied'),
                                                              backgroundColor:
                                                                  Color(hexColor(
                                                                      '#373a40')),
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          1),
                                                            ));
                                                          }),
                                                      Text(
                                                        '|',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[300]),
                                                      ),
                                                      // _pangindananBtn()
                                                      IconButton(
                                                        icon: new Icon(
                                                          Icons.bookmark_border,
                                                          color: Colors.grey,
                                                        ),
                                                        // icon: (_isFavorited
                                                        //     ? Icon(Icons.bookmark_border)
                                                        //     : Icon(Icons.bookmark)),
                                                        // color: Colors.blue[500],
                                                        // icon: Icon(
                                                        //   i != null &&
                                                        //           i ==
                                                        //               snapshot.data.translations
                                                        //                   .id.text[key]
                                                        //       ? Icons.bookmark
                                                        //       : Icons.bookmark_border,
                                                        //   color: i != null &&
                                                        //           i ==
                                                        //               snapshot.data.translations
                                                        //                   .id.text[key]
                                                        //       ? Colors.blue
                                                        //       : Colors.grey,
                                                        // ),
                                                        onPressed:
                                                            _toggleFavorite,
                                                        // onPressed: () {
                                                        //   _onSelected(
                                                        //       snapshot, key);
                                                        //   // Bookmarks e = Bookmarks(
                                                        //   //     i, snapshot.data.text[key]);
                                                        //   // DBHelper.ddb.save(e);
                                                        //   print(i);

                                                        //   // setState(() {});

                                                        //   _scaffoldKey.currentState
                                                        //       .showSnackBar(
                                                        //           SnackBar(
                                                        //     content: Text(
                                                        //         'Added to Pangindanan'),
                                                        //     backgroundColor: Color(
                                                        //         hexColor(
                                                        //             '#373a40')),
                                                        //     duration: Duration(
                                                        //         seconds: 1),
                                                        //   ));
                                                        // }
                                                        // ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          })
                                      : Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        )
                                ]);
                              },
                            )),
                ],
              ));
  }

  // String _selectedIndex;
  // void _onSelected(snapshot, key) {
  //   _selectedIndex = snapshot.data.text[key];
  //   // + '\n' +
  //   //     snapshot.data.translations.id.text[key];
  //   Bookmarks e = Bookmarks(null, _selectedIndex);
  //   DBHelper.ddb.save(e);
  //   print(_selectedIndex);
  //   // setState(() {});
  // }

  void _onButtonPressed(snapshot, key) {
    // String key = snapshot.data.text.keys.elementAt(i);
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 450,
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
          contentPadding: EdgeInsets.all(18),
          // leading: Icon(Icons.info),
          title: Text(
              'Parsawahan:\n' + snapshot.data.tafsir.id.parsawahan.text[key]),
          // onTap: () => _selectItem('In shaa Allah'),
        )
      ],
    );
  }

  @override
  Widget _pangindananBtn() {
    var ui = Provider.of<UI>(context);
    return IconButton(
      icon: Icon(Icons.bookmark),
      onPressed: () {},
    );
  }

  // @override
  // Widget _pangindananBtn() {
  //   var ui = Provider.of<UI>(context);
  //   return Scaffold(
  //     body: FutureBuilder<List<Bookmarks>>(
  //       future: DBHelper.ddb.getPangindanan(),
  //       // stream: myDatabase.getEmployees().asStream(),
  //       builder: (context, AsyncSnapshot<List<Bookmarks>> snapshot) {
  //         return snapshot.hasData
  //             ? IconButton(
  //                 icon: Icon(Icons.delete),
  //                 onPressed: () {
  //                   setState(() => {});
  //                 })
  //             : Center(child: CircularProgressIndicator());
  //       },
  //     ),
  //   );
  // }
}
