class UserModel {
  String? uId;
  String? name;
  String? email;
  String? date;
  String? image;
  String? cover;
  String? bio;
  int? following;
  int? followers;
  UserModel({
    this.uId,
    this.name,
    this.email,
    this.date,
    this.image,
    this.cover,
    this.bio,
    this.following,
    this.followers,
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    name = json['name'];
    email = json['email'];
    date = json['date'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    following = json['following'];
    followers = json['followers'];
  }
  Map<String, dynamic>? toJson() {
    return {
      'uId': uId,
      'name': name,
      'email': email,
      'date': date,
      'image': image,
      'cover': cover,
      'bio': bio,
      'following': following,
      'followers': followers,
    };
  }
}
