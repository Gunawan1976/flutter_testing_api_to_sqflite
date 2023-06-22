import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_api_to_sqflite/provider/p_posts.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final postProvider = Provider.of<ProviderPosts>(context, listen: false);
    postProvider.fetchData();
    postProvider.fetchPostsFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: Consumer<ProviderPosts>(
        builder: (context, postProvider, _) {
          if (postProvider.post.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: postProvider.post.length,
            itemBuilder: (context, index) {
              final post = postProvider.post[index];
              print(post);
              return ListTile(
                leading: Text("${index++}"),
                title: Text(post.title!),
                subtitle: Text(post.body!),
              );
            },
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // final postProvider =
      //     //     Provider.of<ProviderPosts>(context, listen: false);
      //     // postProvider.fetchData();
      //   },
      //   child: Icon(Icons.refresh),
      // ),
    );
  }
}
