class TweetModel {
  String? tweetId;
  String? userId;
  String? name;
  String? email;
  String? profileImage;
  String? tweetDate;
  String? tweetTime;
  String? tweetText;
  String? tweetImage;
  // fix this
  // List<Likes>? likes;
  //

  TweetModel({
    this.tweetId,
    this.userId,
    this.name,
    this.email,
    this.profileImage,
    this.tweetDate,
    this.tweetTime,
    this.tweetText,
    this.tweetImage,
    // fix this
    // this.likes,
    //
  });

  TweetModel.fromJson(json) {
    tweetId = json['tweetId'];
    userId = json['userId'];
    name = json['name'];
    email = json['email'];
    profileImage = json['profileImage'];
    tweetDate = json['tweetDate'];
    tweetTime = json['tweetTime'];
    tweetText = json['tweetText'];
    tweetImage = json['tweetImage'];

    // fix this
    // if (json['likes'] != null) {
    //   likes = <Likes>[];
    //   json['likes'].forEach((v) {
    //     likes!.add(Likes.fromJson(v));
    //   });
    // }
    //
  }

  Map<String, dynamic>? toMap() {
    return {
      'tweetId': tweetId,
      'userId': userId,
      'name': name,
      'email': email,
      'profileImage': profileImage,
      'tweetDate': tweetDate,
      'tweetTime': tweetTime,
      'tweetText': tweetText,
      'tweetImage': tweetImage,
    };
  }
}
