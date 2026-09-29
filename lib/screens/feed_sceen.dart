import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meet_my_app_buyer/common/appBar/primary_appBar.dart';
import 'package:meet_my_app_buyer/providers/post_provider.dart';
import 'package:meet_my_app_buyer/widgets/post/post_card.dart';
import 'package:meet_my_app_buyer/widgets/post/create_post.dart'; // tomar CreatePostCard ekhane

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // dummyPosts shorashori na niye Provider theke live list nichhi
    final posts = context.watch<PostProvider>().posts;

    return Scaffold(
      appBar: Primary_AppBar(textColor: Colors.black),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const CreatePostCard(),
          const SizedBox(height: 16),
          if (posts.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Center(child: Text('No post here')),
            )
          else
            ...posts.map(
              (post) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: PostCard(post: post),
              ),
            ),
        ],
      ),
    );
  }
}
