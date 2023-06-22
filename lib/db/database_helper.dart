import 'package:sqflite/sqflite.dart';
import 'package:testing_api_to_sqflite/model/model_testing.dart';

class DatabaseHelper {
  late Database _database;

  Future<void> open() async {
    _database = await openDatabase(
      'posts.db',
      version: 6,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE posts(id INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER, title TEXT, body TEXT
          )
        ''');
      },
    );
  }

  Future<List<int>> savePosts(List<ModelTesting> posts) async {
    final List<int> insertedIds = [];
    for (var post in posts) {
      final id = await _database.insert('posts', post.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      insertedIds.add(id);
    }
    return insertedIds;
    // for (var post in posts) {
    //   await _database.insert('posts', post.toJson(),
    //       conflictAlgorithm: ConflictAlgorithm.replace);
    // }
  }

  Future<List<ModelTesting>> getPosts() async {
    final List<Map<String, dynamic>> results = await _database.query('posts');
    return results.map((json) => ModelTesting.fromJson(json)).toList();
  }

  Future<List<ModelTesting>> getPostsByIds(List<int> ids) async {
    final List<Map<String, dynamic>> results = await _database.query(
      'posts',
      where: 'id IN (${ids.map((id) => '?').join(',')})',
      whereArgs: ids,
    );
    return results.map((json) => ModelTesting.fromJson(json)).toList();
  }

  Future closeDB() async {
    _database.close();
  }
}
