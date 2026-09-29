import 'package:flutter/material.dart';
import 'package:meet_my_app_buyer/models/profile/post_model.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Author row: avatar + name + time + 3-dot menu
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.amber.shade100,
                child: const Icon(
                  Icons.storefront,
                  size: 18,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      post.postTime,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.more_vert, color: Colors.grey),
            ],
          ),

          const SizedBox(height: 10),

          // 2. Post content text
          Text(
            post.postText,
            style: const TextStyle(fontSize: 13.5, height: 1.4),
          ),

          // 3. Image (only if imgUrl exists)
          if (post.imgUrl != null) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                post.imgUrl!,
                width: double.infinity,
                height: 160,
                fit: BoxFit.cover,
              ),
            ),
          ],

          const SizedBox(height: 12),
          Divider(color: Colors.grey.shade200, height: 1),
          const SizedBox(height: 8),

          // 4. Interested + Comment row
          Row(
            children: [
              Icon(
                post.isInterested ? Icons.thumb_up : Icons.thumb_up_outlined,
                size: 18,
                color: post.isInterested ? Colors.orange : Colors.grey.shade600,
              ),
              const SizedBox(width: 6),
              Text(
                post.interestedCount > 0
                    ? "Interested (${post.interestedCount})"
                    : "Interested",
                style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
              ),
              const SizedBox(width: 20),
              Icon(
                Icons.mode_comment_outlined,
                size: 18,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 6),
              Text(
                "Comment",
                style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
