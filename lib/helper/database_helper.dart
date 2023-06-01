import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initializeDatabase();
    return _db;
  }

  DatabaseHelper._privateConstructor();
  DatabaseHelper.internal();

  Future<Database> initializeDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'newsApp.db');
    final myDb = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY,
            username TEXT,
            password TEXT
          )
        ''');
      },
    );

    return myDb;
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await this.db;
    final result = await db!.insert('users', user);
    return result;
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await this.db;
    final result = await db!.query('users');
    return result;
  }

  Future<List<Map<String, dynamic>>> selectUser(String username) async {
    final db = await this.db;
    final result = await db!.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
    return result;
  }
}