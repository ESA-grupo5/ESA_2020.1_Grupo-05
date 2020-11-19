import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await _initDb();
    return _db;
  }

  DatabaseHelper.internal();

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'flashly.db';
    final todoListDb =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return todoListDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, password TEXT)',
    );
    await db.execute(
      'CREATE TABLE subjects (id INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER, name TEXT)',
    );
    await db.execute(
      'CREATE TABLE topics (id INTEGER PRIMARY KEY AUTOINCREMENT, subjectId INTEGER, name TEXT, color TEXT)',
    );
    await db.execute(
      'CREATE TABLE paperboards (id INTEGER PRIMARY KEY AUTOINCREMENT, topicId INTEGER, front TEXT, back TEXT)',
    );
  }
}
