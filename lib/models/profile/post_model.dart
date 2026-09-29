class PostModel {
  final String userName;
  final String postTime;
  final String postText;
  final String? imgUrl;
  final int interestedCount;
  final bool isInterested;

  

  PostModel({required this.userName,  this.imgUrl, required this.postTime, required this.postText,  this.interestedCount=0,  this.isInterested = false });
}
