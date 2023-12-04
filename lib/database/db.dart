import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  //Privar construtor
  DB._();
  //Instancia de DB
  static final DB instance = DB._();
  //Instancia do SQLite
  static Database? _database;

  get database async {
    if (_database != null) return _database;

    return await _initDatabase();
  }

  _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'recipeapp.db'),
      onCreate: (db, version) => db.execute(_recipe),
      version: 1,
    );
  }

  String get _recipe => '''
    CREATE TABLE recipe (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        image TEXT,
        rating REAL,
        time TEXT,
        ingredients TEXT,
        steps TEXT
      );
  ''';
}
