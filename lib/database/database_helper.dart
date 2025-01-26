import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/news_model.dart';

class DatabaseHelper {
  static Database? _database;
  static const String tableName = 'news';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'news.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''
        CREATE TABLE $tableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          description TEXT,
          author TEXT,
          url TEXT,
          urlToImage TEXT,
          publishedAt TEXT,
          content TEXT
        )
      ''');
    });
  }

  Future<void> insertNews(List<NewsModel> news) async {
    final db = await database;
    await db.delete(tableName); // Clear old data
    for (var article in news) {
      await db.insert(tableName, article.toJson());
    }
  }

  Future<List<NewsModel>> getNews() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) => NewsModel.fromJson(maps[i]));
  }
}
