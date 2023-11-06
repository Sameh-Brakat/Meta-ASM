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
  int? numberOfComments;
  int? numberOfLikes;
  int? numberOfViews;
  int? numberOfRetweets;
  int? numberOfQuotes;
  int? numberOfBookmarks;
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
  }) {
    numberOfComments = 0;
    numberOfLikes = 0;
    numberOfViews = 0;
    numberOfRetweets = 0;
    numberOfQuotes = 0;
    numberOfBookmarks = 0;
  }

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
    numberOfComments = json['number_of_comments'];
    numberOfLikes = json['number_of_likes'];
    numberOfViews = json['number_of_views'];
    numberOfRetweets = json['number_of_retweets'];
    numberOfQuotes = json['number_of_quotes'];
    numberOfBookmarks = json['number_of_bookmarks'];

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
      'number_of_comments': numberOfComments,
      'number_of_likes': numberOfLikes,
      'number_of_views': numberOfViews,
      'number_of_retweets': numberOfRetweets,
      'number_of_quotes': numberOfQuotes,
      'number_of_bookmarks': numberOfBookmarks,
      // 'likes':
      //     likes != null ? likes!.map((like) => like.toMap()).toList() : null,
    };
  }
}

// if any prob here fix it
class Likes {
  bool? like;
  Likes() {
    like = false;
  }
  Likes.fromJson(json) {
    like = json['like'];
  }
  Map<String, dynamic>? toMap() {
    return {
      'like': like,
    };
  }
}
