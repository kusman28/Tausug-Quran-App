// بسم الله الرحمن الرحيم
// O' Tuhan namu papag-barakata kamu in Application ini
// sarta tarbilanga kami dayng ha mga Mukhliseen. Ameen
import 'package:flutter/material.dart';
import 'package:tausug_tafseer/controllers/DBHelper.dart';
import 'package:tausug_tafseer/controllers/Pangindanan.dart';
import 'package:provider/provider.dart';
import 'package:tausug_tafseer/style/UI.dart';

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
                    print(ayat.id);
                    return ListTile(
                      title: Text(
                        snapshot.data[index].ayat,
                        style: TextStyle(
                          fontFamily: 'Arabic',
                          fontSize: ui.fontSize,
                          height: 1.5,
                        ),
                      ),
                      // subtitle: Text(
                      //   snapshot.data[index].ayat,
                      // ),
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            DBHelper.ddb.delete(ayat.id);
                            setState(() => {});
                          }),
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             Test(ayat.id)));
                      },
                    );
                  })
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
