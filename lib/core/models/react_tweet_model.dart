class LikeTweetModel {
  bool? like;
  LikeTweetModel({this.like});

  LikeTweetModel.fromJson(json) {
    like = json['like'];
  }

  Map<String, dynamic>? toMap() {
    return {
      'like': like,
    };
  }
}
