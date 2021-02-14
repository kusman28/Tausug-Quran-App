// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FavoriteDAO _favoriteDAOInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Favorite` (`id` INTEGER, `uid` TEXT, `ayat` TEXT, `tafsir` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FavoriteDAO get favoriteDAO {
    return _favoriteDAOInstance ??= _$FavoriteDAO(database, changeListener);
  }
}

class _$FavoriteDAO extends FavoriteDAO {
  _$FavoriteDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _favoriteInsertionAdapter = InsertionAdapter(
            database,
            'Favorite',
            (Favorite item) => <String, dynamic>{
                  'id': item.id,
                  'uid': item.uid,
                  'ayat': item.ayat,
                  'tafsir': item.tafsir
                }),
        _favoriteDeletionAdapter = DeletionAdapter(
            database,
            'Favorite',
            ['id'],
            (Favorite item) => <String, dynamic>{
                  'id': item.id,
                  'uid': item.uid,
                  'ayat': item.ayat,
                  'tafsir': item.tafsir
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Favorite> _favoriteInsertionAdapter;

  final DeletionAdapter<Favorite> _favoriteDeletionAdapter;

  @override
  Future<Favorite> getFavInFavByUid(String uid, int id) async {
    return _queryAdapter.query('SELECT * FROM Favorite WHERE uid=? AND id=?',
        arguments: <dynamic>[uid, id],
        mapper: (Map<String, dynamic> row) => Favorite(
            row['id'] as int,
            row['uid'] as String,
            row['ayat'] as String,
            row['tafsir'] as String));
  }

  @override
  Future<void> insertFav(Favorite fav) async {
    await _favoriteInsertionAdapter.insert(fav, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteFav(Favorite fav) {
    return _favoriteDeletionAdapter.deleteAndReturnChangedRows(fav);
  }
}
