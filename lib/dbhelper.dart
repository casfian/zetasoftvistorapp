import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';

class MyDatabaseHelper {
  static Database? _database;

  // 1. Get the database (singleton pattern)
  static Future<Database> getDatabase() async {
    if (_database != null) return _database!;

    // Get the path to the documents directory
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'mydatabase.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );

    return _database!;
  }

  // 2. onCreate: called when DB is first created
  static Future _onCreate(Database db, int version) async {
    await _createUsersTable(db);
    await _createVisitorsTable(db);
  }

  // 3. Create users table
  static Future _createUsersTable(Database db) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL
      )
    ''');
  }

  // 4. Create visitors table
  static Future _createVisitorsTable(Database db) async {
    await db.execute('''
      CREATE TABLE visitors (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        visitDate TEXT NOT NULL,
        purpose TEXT
      )
    ''');
  }
  
}
