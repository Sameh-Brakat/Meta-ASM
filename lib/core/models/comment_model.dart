class CommentModel {
  String? commentId;
  String? comment;
  String? commentImage;
  String? dateComment;
  String? userId;
  String? userName;
  String? userEmail;
  String? userProfileImage;

  CommentModel({
    this.commentId,
    this.comment,
    this.commentImage,
    this.dateComment,
    this.userId,
    this.userName,
    this.userEmail,
    this.userProfileImage,
  });

  CommentModel.fromJson(json) {
    commentId = json['commentId'];
    comment = json['comment'];
    commentImage = json['commentImage'];
    dateComment = json['dateComment'];
    userId = json['userId'];
    userName = json['userName'];
    userEmail = json['userEmail'];
    userProfileImage = json['userProfileImage'];
  }

  Map<String, dynamic>? toMap() {
    return {
      'commentId': commentId,
      'comment': comment,
      'commentImage': commentImage,
      'dateComment': dateComment,
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'userProfileImage': userProfileImage,
    };
  }
}
