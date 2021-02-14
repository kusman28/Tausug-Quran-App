// بسم الله الرحمن الرحيم
// O' Tuhan namu papag-barakata kamu in Application ini
// sarta tarbilanga kami dayng ha mga Mukhliseen. Ameen
import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tausug_tafseer/controllers/Pangindanan.dart';

class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String AYAT = 'ayat';
  static const String TABLE = 'Pangindanan';
  static const String DB_NAME = 'pangindanan.db';

  DBHelper._();

  static final DBHelper ddb = DBHelper._();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db
        .execute("CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $AYAT TEXT)");
  }

  Future<Bookmarks> save(Bookmarks pangindanan) async {
    var dbClient = await db;
    pangindanan.id = await dbClient.insert(TABLE, pangindanan.toMap());
    return pangindanan;
    /*
    await dbClient.transaction((txn) async {
      var query = "INSERT INTO $TABLE ($NAME) VALUES ('" + employee.name + "')";
      return await txn.rawInsert(query);
    });
    */
  }

  Future<List<Bookmarks>> getPangindanan() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [ID, AYAT]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Bookmarks> mgaPangindanan = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        mgaPangindanan.add(Bookmarks.fromMap(maps[i]));
      }
    }
    return mgaPangindanan;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  // Future<int> update(Pangindanan pangindanan) async {
  //   var dbClient = await db;
  //   return await dbClient.update(TABLE, pangindanan.toMap(),
  //       where: '$ID = ?', whereArgs: [pangindanan.id]);
  // }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
