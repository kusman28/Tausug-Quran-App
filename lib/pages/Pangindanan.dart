// بسم الله الرحمن الرحيم
// O' Tuhan namu papag-barakata kamu in Application ini
// sarta tarbilanga kami dayng ha mga Mukhliseen. Ameen
import 'package:flutter/material.dart';
import 'package:tausug_tafseer/controllers/DBHelper.dart';
import 'package:tausug_tafseer/controllers/Pangindanan.dart';

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
    return Scaffold(
      body: FutureBuilder<List<Bookmarks>>(
        future: DBHelper.ddb.getPangindanan(),
        // stream: myDatabase.getEmployees().asStream(),
        builder: (context, AsyncSnapshot<List<Bookmarks>> snapshot) {
          return snapshot.hasData
              ? ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                        color: Colors.grey,
                      ),
                  itemCount: snapshot.data?.length,
                  itemBuilder: (_, index) {
                    Bookmarks ayat = snapshot.data[index];

                    return ListTile(
                      title: Text(snapshot.data[index].ayat),
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            DBHelper.ddb.delete(ayat.id);
                            // TODO(fitza): verify that this is or isn't best practice
                            setState(() => {});
                          }),
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             HackerNewsWebPage(article.url)));
                      },
                    );
                  })
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
