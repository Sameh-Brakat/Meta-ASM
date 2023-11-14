import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/core/constants.dart';
import 'package:social_app/core/models/comment_model.dart';
import 'package:social_app/core/models/react_tweet_model.dart';
import 'package:social_app/core/models/tweet_model.dart';
import 'package:social_app/core/styles/icon_broken.dart';
import 'package:social_app/features/home/home_page/presentation/controller/home_cubit/home_cubit.dart';

class TweetPreview extends StatelessWidget {
  TweetPreview({super.key, required this.tweet, required this.likeValue});
  TweetModel tweet;
  bool likeValue;
  var commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference reactsTweet = FirebaseFirestore.instance
        .collection('tweets')
        .doc(tweet.tweetId)
        .collection('reacts');
    CollectionReference commentsTweet = FirebaseFirestore.instance
        .collection('tweets')
        .doc(tweet.tweetId)
        .collection('comments');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(IconBroken.Arrow___Left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Tweet'),
      ),
      body: StreamBuilder(
        stream: reactsTweet.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  if (tweet.profileImage != null)
                                    CircleAvatar(
                                      radius: 18,
                                      backgroundImage: NetworkImage(
                                        tweet.profileImage!,
                                      ),
                                    ),
                                  if (tweet.profileImage == null)
                                    const CircleAvatar(
                                        radius: 18,
                                        backgroundImage: AssetImage(
                                            'assets/images/profile.jpg')),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            tweet.name!,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w900,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                          const Icon(
                                            Icons.verified,
                                            color: Colors.blue,
                                            size: 15,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        tweet.email!,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              if (tweet.tweetText != null)
                                const SizedBox(
                                  height: 20,
                                ),
                              Text(
                                tweet.tweetText!,
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (tweet.tweetImage != null)
                                Image.network(
                                  "${tweet.tweetImage}",
                                  fit: BoxFit.contain,
                                ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    tweet.tweetTime!,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black.withOpacity(0.6),
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    tweet.tweetDate!.substring(0, 10),
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black.withOpacity(0.6),
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Text(
                                  //       '${tweet.numberOfViews} ',
                                  //       style: const TextStyle(
                                  //           fontSize: 15,
                                  //           fontWeight: FontWeight.bold,
                                  //           overflow: TextOverflow.ellipsis),
                                  //     ),
                                  //     Text(
                                  //       'Views',
                                  //       style: TextStyle(
                                  //           fontSize: 15,
                                  //           color: Colors.grey[600],
                                  //           fontWeight: FontWeight.bold,
                                  //           overflow: TextOverflow.ellipsis),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: Colors.grey[200],
                                height: 1,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  StreamBuilder(
                                    stream: commentsTweet.snapshots(),
                                    builder: (context, snapshot) {
                                      return Row(
                                        children: [
                                          Text(
                                            "${snapshot.data?.docs.length}",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                          Text(
                                            ' Comments',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey[600],
                                                fontWeight: FontWeight.bold,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  // const SizedBox(
                                  //   width: 10,
                                  // ),
                                  // Row(
                                  //   children: [
                                  //     Text(
                                  //       '${tweet.numberOfQuotes} ',
                                  //       style: const TextStyle(
                                  //           fontSize: 15,
                                  //           fontWeight: FontWeight.bold,
                                  //           overflow: TextOverflow.ellipsis),
                                  //     ),
                                  //     Text(
                                  //       'Quotes',
                                  //       style: TextStyle(
                                  //           fontSize: 15,
                                  //           color: Colors.grey[600],
                                  //           fontWeight: FontWeight.bold,
                                  //           overflow: TextOverflow.ellipsis),
                                  //     ),
                                  //   ],
                                  // ),
                                  const SizedBox(
                                    width: 10,
                                  ),

                                  Row(
                                    children: [
                                      Text(
                                        ' ${snapshot.data?.docs.where((element) => element['like'] == true).length}',
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      // Text(
                                      //   '${tweet.numberOfLikes} ',
                                      //   style: const TextStyle(
                                      //       fontSize: 15,
                                      //       fontWeight: FontWeight.bold,
                                      //       overflow: TextOverflow.ellipsis),
                                      // ),
                                      Text(
                                        ' Likes',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    icon: Icon(
                                      IconBroken.Heart,
                                      size: 30,
                                      color:
                                          likeValue ? Colors.red : Colors.black,
                                    ),
                                    onPressed: () {
                                      if (likeValue) {
                                        FirebaseFirestore.instance
                                            .collection('tweets')
                                            .doc(tweet.tweetId)
                                            .collection('reacts')
                                            .doc(uId)
                                            .set({'like': false});
                                        likeValue = false;
                                      } else {
                                        FirebaseFirestore.instance
                                            .collection('tweets')
                                            .doc(tweet.tweetId)
                                            .collection('reacts')
                                            .doc(uId)
                                            .set({'like': true});
                                        likeValue = true;
                                      }
                                    },
                                  ),
                                ],
                              ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              // Divider(
                              //   color: Colors.grey[200],
                              //   height: 1,
                              // ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              // Row(
                              //   children: [
                              //     Row(
                              //       children: [
                              //         Text(
                              //           '${tweet.numberOfBookmarks} ',
                              //           style: const TextStyle(
                              //               fontSize: 15,
                              //               fontWeight: FontWeight.bold,
                              //               overflow: TextOverflow.ellipsis),
                              //         ),
                              //         Text(
                              //           'Bookmarks',
                              //           style: TextStyle(
                              //               fontSize: 15,
                              //               color: Colors.grey[600],
                              //               fontWeight: FontWeight.bold,
                              //               overflow: TextOverflow.ellipsis),
                              //         ),
                              //       ],
                              //     ),
                              //   ],
                              // ),
                              const SizedBox(
                                height: 15,
                              ),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 10),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.end,
                              //     children: [
                              //       // IconButton(
                              //       //   icon: const Icon(
                              //       //     IconBroken.Arrow___Up_Square,
                              //       //     size: 30,
                              //       //     color: Colors.black,
                              //       //   ),
                              //       //   onPressed: () {},
                              //       // ),
                              //       // IconButton(
                              //       //   icon: const Icon(
                              //       //     IconBroken.Message,
                              //       //     size: 30,
                              //       //     color: Colors.black,
                              //       //   ),
                              //       //   onPressed: () {},
                              //       // ),
                              //       // IconButton(
                              //       //   icon: const Icon(
                              //       //     IconBroken.Download,
                              //       //     size: 30,
                              //       //     color: Colors.black,
                              //       //   ),
                              //       //   onPressed: () {},
                              //       // ),
                              //       // IconButton(
                              //       //   icon: const Icon(
                              //       //     IconBroken.Send,
                              //       //     size: 30,
                              //       //     color: Colors.black,
                              //       //   ),
                              //       //   onPressed: () {},
                              //       // ),
                              //     ],
                              //   ),
                              // )
                            ],
                          ),
                          Divider(
                            color: Colors.grey[200],
                            height: 1,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          StreamBuilder(
                            stream: commentsTweet
                                .orderBy('dateComment')
                                .snapshots(),
                            builder: (context, snapshotComment) {
                              if (snapshotComment.hasData) {
                                return ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      // print();
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              if (snapshotComment
                                                      .data!.docs[index]
                                                      .get(
                                                          'userProfileImage') !=
                                                  null)
                                                CircleAvatar(
                                                  radius: 14,
                                                  backgroundImage: NetworkImage(
                                                    snapshotComment
                                                        .data!.docs[index]
                                                        .get(
                                                            'userProfileImage'),
                                                  ),
                                                ),
                                              if (tweet.profileImage == null)
                                                const CircleAvatar(
                                                    radius: 14,
                                                    backgroundImage: AssetImage(
                                                        'assets/images/profile.jpg')),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    snapshotComment
                                                        .data!.docs[index]
                                                        .get('userName'),
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                                  const Icon(
                                                    Icons.verified,
                                                    color: Colors.blue,
                                                    size: 15,
                                                  ),
                                                  Text(
                                                    snapshotComment
                                                        .data!.docs[index]
                                                        .get('userEmail'),
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey[600],
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Text(
                                              snapshotComment.data!.docs[index]
                                                  .get('comment'),
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          // if (tweet.tweetImage != null)
                                          //   Image.network(
                                          //     "${tweet.tweetImage}",
                                          //     fit: BoxFit.contain,
                                          //   ),
                                          // const SizedBox(
                                          //   height: 5,
                                          // ),
                                          // Padding(
                                          //   padding: const EdgeInsets.symmetric(
                                          //       horizontal: 10),
                                          //   child: Row(
                                          //     mainAxisAlignment:
                                          //         MainAxisAlignment.end,
                                          //     children: [
                                          //       // const SizedBox(
                                          //       //   width: 70,
                                          //       // ),
                                          //       StreamBuilder(
                                          //         stream: snapshot.data!
                                          //             .docs[index].reference
                                          //             .collection('likes')
                                          //             .doc(uId)
                                          //             .snapshots(),
                                          //         builder:
                                          //             (context, likeSnapshot) {
                                          //           bool likeCommentValue =
                                          //               false;
                                          //           if (likeSnapshot.hasData &&
                                          //               likeSnapshot
                                          //                   .data!.exists) {
                                          //             final data = likeSnapshot
                                          //                     .data!
                                          //                     .data()
                                          //                 as Map<String,
                                          //                     dynamic>; // Cast to the expected type
                                          //             if (data['like'] !=
                                          //                 null) {
                                          //               likeCommentValue = data[
                                          //                       'like']
                                          //                   as bool; // Cast to bool if it's of that type
                                          //             }
                                          //           }
                                          //           return IconButton(
                                          //             icon: Row(
                                          //               children: [
                                          //                 Icon(
                                          //                   IconBroken.Heart,
                                          //                   color:
                                          //                       likeCommentValue
                                          //                           ? Colors.red
                                          //                           : Colors
                                          //                               .black,
                                          //                   size: 20,
                                          //                 ),
                                          //                 Text(
                                          //                     ' ${snapshotComment.data?.docs.where((element) {
                                          //                   final data = element
                                          //                           .data()
                                          //                       as Map<String,
                                          //                           dynamic>;
                                          //                   return data
                                          //                       .containsKey(
                                          //                           'likes');
                                          //                 }).length}'),
                                          //               ],
                                          //             ),
                                          //             onPressed: () {
                                          //               CommentModel
                                          //                   commentModel =
                                          //                   CommentModel(
                                          //                       comment: value,
                                          //                       userName:
                                          //                           HomeCubit
                                          //                               .userModel!
                                          //                               .name,
                                          //                       userEmail:
                                          //                           HomeCubit
                                          //                               .userModel!
                                          //                               .email,
                                          //                       userId: uId,
                                          //                       dateComment: DateTime
                                          //                               .now()
                                          //                           .toString());
                                          //               FirebaseFirestore
                                          //                   .instance
                                          //                   .collection(
                                          //                       'tweets')
                                          //                   .doc(tweet.tweetId)
                                          //                   .collection(
                                          //                       'comments')
                                          //                   .add(commentModel
                                          //                       .toMap()!)
                                          //                   .then((value) {
                                          //                 commentModel
                                          //                         .commentId =
                                          //                     value.id;
                                          //                 value.update({
                                          //                   'commentId':
                                          //                       value.id
                                          //                 });
                                          //                 commentController
                                          //                     .clear();
                                          //               });
                                          //               if (likeCommentValue) {
                                          //                 FirebaseFirestore
                                          //                     .instance
                                          //                     .collection(
                                          //                         'tweets')
                                          //                     .doc(
                                          //                         tweet.tweetId)
                                          //                     .collection(
                                          //                         'comments')
                                          //                     .doc(uId)
                                          //                     .set({
                                          //                   'like': false
                                          //                 });
                                          //                 likeCommentValue =
                                          //                     false;
                                          //               } else {
                                          //                 FirebaseFirestore
                                          //                     .instance
                                          //                     .collection(
                                          //                         'tweets')
                                          //                     .doc(
                                          //                         tweet.tweetId)
                                          //                     .collection(
                                          //                         'comments')
                                          //                     .doc(uId)
                                          //                     .set({
                                          //                   'like': true
                                          //                 });
                                          //                 likeCommentValue =
                                          //                     true;
                                          //               }
                                          //             },
                                          //           );
                                          //         },
                                          //       ),
                                          //       // IconButton(
                                          //       //   icon: Row(
                                          //       //     children: [
                                          //       //       const Icon(
                                          //       //           IconBroken.Message),
                                          //       //       Text(
                                          //       //           ' ${snapshotComment.data!.docs.where((element) {
                                          //       //         final data =
                                          //       //             element.data()
                                          //       //                 as Map<String,
                                          //       //                     dynamic>;
                                          //       //         return data.containsKey(
                                          //       //             'comment');
                                          //       //       }).length}'),
                                          //       //     ],
                                          //       //   ),
                                          //       //   onPressed: () {},
                                          //       // ),
                                          //       // IconButton(
                                          //       //   icon: const Icon(
                                          //       //     IconBroken.Send,
                                          //       //     size: 20,
                                          //       //     color: Colors.black,
                                          //       //   ),
                                          //       //   onPressed: () {},
                                          //       // ),
                                          //     ],
                                          //   ),
                                          // )
                                        ],
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                          color: Colors.grey[100],
                                        ),
                                    itemCount:
                                        snapshotComment.data!.docs.length);
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: commentController,
                        onFieldSubmitted: (value) {
                          CommentModel commentModel = CommentModel(
                              comment: value,
                              userName: HomeCubit.userModel!.name,
                              userEmail: HomeCubit.userModel!.email,
                              userId: uId,
                              dateComment: DateTime.now().toString());
                          FirebaseFirestore.instance
                              .collection('tweets')
                              .doc(tweet.tweetId)
                              .collection('comments')
                              .add(commentModel.toMap()!)
                              .then((value) {
                            commentModel.commentId = value.id;
                            value.update({'commentId': value.id});
                            commentController.clear();
                          });
                        },
                        decoration: const InputDecoration(
                            hintText: 'Tweet your reply',
                            border: InputBorder.none),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        IconBroken.Send,
                        color: Colors.blue,
                        size: 27,
                      ),
                      onPressed: () {
                        if (commentController.text.isNotEmpty) {
                          CommentModel commentModel = CommentModel(
                              comment: commentController.text,
                              userName: HomeCubit.userModel!.name,
                              userEmail: HomeCubit.userModel!.email,
                              userId: uId,
                              dateComment: DateTime.now().toString());
                          FirebaseFirestore.instance
                              .collection('tweets')
                              .doc(tweet.tweetId)
                              .collection('comments')
                              .add(commentModel.toMap()!)
                              .then((value) {
                            commentModel.commentId = value.id;
                            value.update({'commentId': value.id});
                            commentController.clear();
                          });
                        }
                      },
                    ),
                    // IconButton(
                    //   icon: const Icon(
                    //     IconBroken.Camera,
                    //     color: Colors.blue,
                    //     size: 27,
                    //   ),
                    //   onPressed: () {},
                    // ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
