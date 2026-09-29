import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meet_my_app_buyer/providers/post_provider.dart';
import 'package:meet_my_app_buyer/widgets/post/create_post.dart';
import 'package:meet_my_app_buyer/widgets/post/post_card.dart';

class PostTab extends StatelessWidget {
  const PostTab({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = context.watch<PostProvider>().posts;

    return Column(
      children: [
        const CreatePostCard(),
        const SizedBox(height: 12),
        ...posts.map(
          (post) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: PostCard(post: post),
          ),
        ),
      ],
    );
  }
}
