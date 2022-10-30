import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const _tblFavorite = 'favorites';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurants-app.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblFavorite (
          id TEXT PRIMARY KEY,
          name TEXT,
          description TEXT,
          pictureId TEXT,
          city TEXT,
          rating REAL
        )''');
      },
      version: 1,
    );

    return db;
  }

  Future<Database?> get database async {
    return _database ?? await _initializeDb();
  }

  Future<List<Restaurant>> getFavorites() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblFavorite);

    return results.map((res) => Restaurant.fromJson(res)).toList();
  }

  Future<void> insertFavorite(Restaurant id) async {
    final db = await database;
    await db!.insert(_tblFavorite, id.toJson());
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> deleteFavorite(String id) async {
    final db = await database;
    db!.delete(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
