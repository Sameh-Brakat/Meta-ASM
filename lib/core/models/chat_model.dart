class ChatModel {
  String? id;
  String? text;

  ChatModel(this.text, this.id);
  factory ChatModel.fromJson(json) {
    return ChatModel(json['text'], json['id']);
  }
}
