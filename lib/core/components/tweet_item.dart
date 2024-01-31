import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:social_app/core/components/tweet_preview.dart';
import 'package:social_app/core/constants.dart';
import 'package:social_app/core/models/react_tweet_model.dart';
import 'package:social_app/core/models/tweet_model.dart';
import 'package:social_app/core/styles/icon_broken.dart';

Widget TweetItem({
  required TweetModel tweet,
  LikeTweetModel? reactTweetModel,
  required context,
}) {
  // print(reactTweetModel.like);
  CollectionReference reactsTweet = FirebaseFirestore.instance
      .collection('tweets')
      .doc(tweet.tweetId)
      .collection('reacts');
  CollectionReference commentsTweet = FirebaseFirestore.instance
      .collection('tweets')
      .doc(tweet.tweetId)
      .collection('comments');
  CollectionReference bookmarksCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(uId)
      .collection('bookmarks');

  return StreamBuilder(
    stream: reactsTweet.snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  backgroundImage: AssetImage('assets/images/profile.jpg')),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        tweet.name!,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(
                        Icons.verified,
                        color: Colors.blue,
                        size: 15,
                      ),
                      Expanded(
                        child: Text(
                          "${tweet.email}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        tweet.tweetDate!.substring(0, 10),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // const Spacer(),
                      const Icon(
                        Icons.more_vert,
                        size: 23,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TweetPreview(
                              tweet: tweet,
                            ),
                          ));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (tweet.tweetText != null)
                          Text(
                            tweet.tweetText!,
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                        if (tweet.tweetText != null)
                          const SizedBox(
                            height: 10,
                          ),
                        if (tweet.tweetImage != null)
                          Image.network(
                            "${tweet.tweetImage}",
                            fit: BoxFit.contain,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return GFShimmer(
                                  mainColor: Colors.grey.withOpacity(0.4),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Column(
                                      // crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 200,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      StreamBuilder(
                          stream: reactsTweet.snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              bool isliked = snapshot.data!.docs
                                  .where((element) => element['userId'] == uId)
                                  .isNotEmpty;

                              return IconButton(
                                icon: Row(
                                  children: [
                                    Icon(
                                      IconBroken.Heart,
                                      color:
                                          isliked ? Colors.red : Colors.black,
                                    ),
                                    Text(' ${snapshot.data?.docs.length}'),
                                  ],
                                ),
                                onPressed: () {
                                  if (isliked) {
                                    reactsTweet
                                        .where('userId', isEqualTo: uId)
                                        .get()
                                        .then((doc) {
                                      doc.docs.forEach((doc) {
                                        doc.reference.delete();
                                      });
                                    }).catchError((e) {
                                      print(e);
                                    });
                                  } else {
                                    reactsTweet.add({'userId': uId});
                                  }
                                },
                              );
                            } else {
                              return Container();
                            }
                          }),

                      const SizedBox(
                        width: 30,
                      ),
                      StreamBuilder(
                        stream: commentsTweet.snapshots(),
                        builder: (context, snapshot) {
                          return IconButton(
                            icon: Row(
                              children: [
                                const Icon(IconBroken.Message),
                                Text(" ${snapshot.data?.docs.length}"),
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TweetPreview(
                                      tweet: tweet,
                                    ),
                                  ));
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      StreamBuilder(
                          stream: bookmarksCollection.snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              bool isBookmarked = snapshot.data!.docs
                                  .where((element) =>
                                      element['tweetId'] == tweet.tweetId)
                                  .isNotEmpty;

                              return IconButton(
                                icon: Icon(
                                  IconBroken.Bookmark,
                                  color:
                                      isBookmarked ? Colors.blue : Colors.black,
                                ),
                                onPressed: () {
                                  if (isBookmarked) {
                                    bookmarksCollection
                                        .where('tweetId',
                                            isEqualTo: tweet.tweetId)
                                        .get()
                                        .then((bookMarkValue) {
                                      bookMarkValue.docs.forEach((doc) {
                                        doc.reference.delete();
                                      });
                                    }).catchError((e) {
                                      print(e);
                                    });
                                  } else {
                                    bookmarksCollection.add(tweet.toMap()!);
                                  }
                                },
                              );
                            } else {
                              return Container();
                            }
                          }),

                      // Row(
                      //   children: [
                      //     const Icon(IconBroken.Arrow___Right_Circle),
                      //     Text(' ${tweet.numberOfRetweets}'),
                      //   ],
                      // ),

                      // Row(
                      //   children: [
                      //     const Icon(IconBroken.Download),
                      //     Text(' ${tweet.numberOfViews}'),
                      //   ],
                      // ),
                      // const Icon(IconBroken.Send),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      } else {
        return Container();
      }
    },
  );
}
