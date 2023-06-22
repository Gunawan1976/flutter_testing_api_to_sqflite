import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_api_to_sqflite/db/database_helper.dart';
import 'package:testing_api_to_sqflite/model/model_testing.dart';

class ProviderPosts extends ChangeNotifier {
  List<ModelTesting> _post = [];
  List<ModelTesting> get post => _post;
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> fetchData() async {
    try {
      final response =
          await Dio().get('https://jsonplaceholder.typicode.com/posts');
      print(response.data);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = response.data;
        _post = jsonData.map((e) => ModelTesting.fromJson(e)).toList();

        await _databaseHelper.open();
        await _databaseHelper.savePosts(_post);

        //var insertedIds = await _databaseHelper.savePosts(_post);
        //_post = await _databaseHelper.getPostsByIds(insertedIds);

        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      print('Failed to fetch posts: $e');
    }
  }

  Future<void> fetchPostsFromDatabase() async {
    try {
      await _databaseHelper.open();
      _post = await _databaseHelper.getPosts();

      notifyListeners();
    } catch (error) {
      debugPrint('Error fetching posts from database: $error');
    }
    _databaseHelper.closeDB();
  }
}
