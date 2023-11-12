import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/constants.dart';
import 'package:social_app/core/models/chat_model.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/features/home/home_page/presentation/controller/home_cubit/home_cubit.dart';
import 'package:social_app/features/home/mails/presentation/controller/mails_screen_cubit.dart';
import 'package:social_app/features/home/mails/presentation/controller/mails_screen_states.dart';
import 'package:social_app/features/home/mails/presentation/view/chat_screen.dart';

class MailsScreen extends StatelessWidget {
  MailsScreen({super.key});

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MailsScreenCubit(),
      child: BlocConsumer<MailsScreenCubit, MailsScreenStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return StreamBuilder<QuerySnapshot>(
            stream: users.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                List<UserModel> users = [];
                for (var i = 0; i < snapshot.data!.docs.length; i++) {
                  if (snapshot.data!.docs[i].id == uId) {
                    continue;
                  }
                  users.add(UserModel.fromJson(snapshot.data!.docs[i]));
                }

                return ListView.separated(
                  itemBuilder: (context, index) {
                    CollectionReference lastSecondUserMessage =
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(uId)
                            .collection('userChats')
                            .doc(users[index].uId)
                            .collection('userMessages');
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                secondUserId: users[index].uId!,
                              ),
                            ));
                      },
                      child: StreamBuilder<QuerySnapshot>(
                        stream: lastSecondUserMessage
                            .orderBy('date', descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<ChatModel> messageList = [];
                            for (var i = 0;
                                i < snapshot.data!.docs.length;
                                i++) {
                              messageList.add(
                                  ChatModel.fromJson(snapshot.data!.docs[i]));
                            }
                            return MessageItem(
                              user: users[index],
                              lastmessage: messageList.isEmpty
                                  ? ''
                                  : messageList[0].text,
                            );
                          } else {
                            return MessageItem(
                              user: users[index],
                            );
                          }
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemCount: users.length,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        },
      ),
    );
  }

  Widget MessageItem({required UserModel user, String? lastmessage}) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (user.image != null)
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                user.image!,
              ),
            ),
          if (user.image == null)
            const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/profile.jpg')),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      user.name!,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          overflow: TextOverflow.ellipsis),
                    ),
                    const Icon(
                      Icons.verified,
                      color: Colors.blue,
                      size: 15,
                    ),
                    Expanded(
                      child: Text(
                        user.email!,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      '15 Mar 22',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  '$lastmessage',
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
