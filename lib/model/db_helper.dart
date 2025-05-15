import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import '../model/movie.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'bookmarks.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE bookmarks (
            id INTEGER PRIMARY KEY,
            title TEXT,
            backdrop_path TEXT,
            release_date TEXT,
            popularity REAL,
            vote_average REAL,
            vote_count INTEGER
          )
        ''');
      },
    );
  }

  Future<int> insertBookmarkMovie(Movie movie) async {
    final db = await database;

    var result = await db.insert(
      'bookmarks',
      movie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return result;
  }

  Future<int> deleteBookmarkMovie(int id) async {
    final db = await database;

    var result = await db.delete('bookmarks', where: 'id = ?', whereArgs: [id]);

    return result;
  }

  Future<List<Movie>> getBookmarkedMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('bookmarks');
    return List.generate(maps.length, (i) => Movie.fromJson(maps[i]));
  }

  Future<bool> isFavorite(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'bookmarks',
      where: 'id = ?',
      whereArgs: [id]
    );
    return maps.isNotEmpty;
  }

  static addBookmarkedMovie(Movie movie) {}
}
