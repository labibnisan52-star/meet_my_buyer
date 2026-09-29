import 'package:flutter/material.dart';
import 'package:meet_my_app_buyer/data/dummy_data.dart';
import 'package:meet_my_app_buyer/models/profile/post_model.dart';

class PostProvider extends ChangeNotifier {
  // shuru te dummy data diye list load kore rakhlam
  final List<PostModel> _posts = List.from(dummyPosts);

  List<PostModel> get posts => _posts;

  // ── Notun post add kora ──────────────────────────────────────────
  void addPost({
    required String userName,
    required String postText,
    String? imgUrl,
  }) {
    final newPost = PostModel(
      userName: userName,
      postTime: "Just now",
      postText: postText,
      imgUrl: imgUrl,
      interestedCount: 0,
      isInterested: false,
    );

    _posts.insert(0, newPost); // notun post shobar upore dekhabe
    notifyListeners();
  }

  // ── "Interested" button tap korle toggle kora ───────────────────
  void toggleInterested(int index) {
    final post = _posts[index];
    final updated = PostModel(
      userName: post.userName,
      postTime: post.postTime,
      postText: post.postText,
      imgUrl: post.imgUrl,
      interestedCount: post.isInterested
          ? post.interestedCount - 1
          : post.interestedCount + 1,
      isInterested: !post.isInterested,
    );
    _posts[index] = updated;
    notifyListeners();
  }
}
