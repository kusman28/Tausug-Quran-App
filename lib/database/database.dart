import 'package:floor/floor.dart';
import 'package:tausug_tafseer/dao/FavoriteDAO.dart';
import 'package:tausug_tafseer/entity/favorite.dart';

import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'database.g.dart';

@Database(version: 1, entities: [Favorite])
abstract class AppDatabase extends FloorDatabase {
  FavoriteDAO get favoriteDAO;
}
