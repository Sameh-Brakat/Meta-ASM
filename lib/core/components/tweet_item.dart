import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/core/components/tweet_preview.dart';
import 'package:social_app/core/constants.dart';
import 'package:social_app/core/models/react_tweet_model.dart';
import 'package:social_app/core/models/tweet_model.dart';
import 'package:social_app/core/styles/icon_broken.dart';

Widget TweetItem({
  required TweetModel tweet,
  LikeTweetModel? reactTweetModel,
  likeValue,
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
  return StreamBuilder(
    stream: reactsTweet.snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        // print(snapshot.data?.docs.any((element) =>
        //     element['like'] ==
        //     true)); // i want to get length user that have like == true
        // ReactTweetModel reactTweetModel = TweetsScreenCubit.get(context)
        //     .getReactTweet(
        //         tweetId: tweet.tweetId!, userId: tweet.userId!);
        // print(reactTweetModel);
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
                              likeValue: likeValue,
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
                          ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // const SizedBox(
                      //   width: 50,
                      // ),
                      InkWell(
                        onTap: () async {
                          // print(await FirebaseFirestore.instance
                          //     .collection('tweets')
                          //     .doc(tweet.tweetId)
                          //     .collection('likes')
                          //     .doc(uId));
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
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              color: likeValue ? Colors.red : Colors.black,
                            ),
                            Text(
                                ' ${snapshot.data?.docs.where((element) => element['like'] == true).length}'),
                          ],
                        ),
                      ),
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
                                      likeValue: likeValue,
                                    ),
                                  ));
                            },
                          );
                        },
                      )

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
