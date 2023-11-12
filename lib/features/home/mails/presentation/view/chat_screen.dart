import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/core/constants.dart';
import 'package:social_app/core/models/chat_model.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.secondUserId});
  final String secondUserId;

  var scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    CollectionReference mainUserMessages = FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('userChats')
        .doc(secondUserId)
        .collection('userMessages');
    CollectionReference SecondUserMessages = FirebaseFirestore.instance
        .collection('users')
        .doc(secondUserId)
        .collection('userChats')
        .doc(uId)
        .collection('userMessages');
    var messageController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Chat'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: mainUserMessages.orderBy('date', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ChatModel> messageList = [];
            for (var i = 0; i < snapshot.data!.docs.length; i++) {
              messageList.add(ChatModel.fromJson(snapshot.data!.docs[i]));
            }
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: ListView.builder(
                        reverse: true,
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          return
                              // ChatBubble(messageList[index].text,
                              //     color: Colors.yellow,
                              //     align: AlignmentDirectional.centerStart);

                              messageList[index].id == uId
                                  ? ChatBubble(messageList[index].text)
                                  : ChatBubble(
                                      messageList[index].text,
                                      color: const Color(0xFF1C9BF0),
                                      align: AlignmentDirectional.centerEnd,
                                      colorMessage: Colors.white,
                                    );
                        },
                        itemCount: messageList.length),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: messageController,
                    onFieldSubmitted: (value) {
                      if (value.isNotEmpty) {
                        mainUserMessages.add({
                          'text': messageController.text,
                          'id': uId,
                          'date': DateTime.now(),
                        });
                        SecondUserMessages.add({
                          'text': messageController.text,
                          'id': uId,
                          'date': DateTime.now(),
                        });
                        messageController.clear();
                        scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.linear,
                        );
                        print(scrollController.position.maxScrollExtent);
                      }
                    },
                    decoration: InputDecoration(
                        hintText: 'Send message',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            if (messageController.text.isNotEmpty) {
                              mainUserMessages.add({
                                'text': messageController.text,
                                'id': uId,
                                'date': DateTime.now(),
                              });
                              SecondUserMessages.add({
                                'text': messageController.text,
                                'id': uId,
                                'date': DateTime.now(),
                              });
                              messageController.clear();
                              scrollController.animateTo(
                                0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.linear,
                              );
                            }
                          },
                        )),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('Write any thing'),
            );
          }
        },
      ),
    );
  }

  Align ChatBubble(
    message, {
    Color color = const Color(0xFFEFF3F4),
    AlignmentGeometry align = AlignmentDirectional.centerStart,
    Color colorMessage = Colors.black,
  }) {
    return Align(
      alignment: align,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: align == AlignmentDirectional.centerStart
              ? BorderRadius.circular(25)
                  .copyWith(bottomLeft: const Radius.circular(0))
              : BorderRadius.circular(25)
                  .copyWith(bottomRight: const Radius.circular(0)),
          color: color,
        ),
        child: Text(
          message,
          style: TextStyle(color: colorMessage),
        ),
      ),
    );
  }
}
