import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_api_to_sqflite/provider/p_posts.dart';
import 'package:testing_api_to_sqflite/view/post_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProviderPosts(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Posts App',
      home: PostScreen(),
    );
  }
}
