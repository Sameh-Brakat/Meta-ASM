import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/core/components/tweet_item.dart';
import 'package:social_app/core/models/react_tweet_model.dart';
import 'package:social_app/core/models/tweet_model.dart';
import 'package:social_app/features/home/posts/presentation/controller/tweets_screen_cubit.dart';

class BookMarksScreen extends StatefulWidget {
  const BookMarksScreen({super.key});

  @override
  State<BookMarksScreen> createState() => _BookMarksScreenState();
}

class _BookMarksScreenState extends State<BookMarksScreen> {
  CollectionReference tweets = FirebaseFirestore.instance.collection('tweets');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'Bookmarks',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: tweets.orderBy('dateTime').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Show a loading indicator while data is loading.
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Error loading posts')); // Handle errors.
          } else {
            List<TweetModel> tweetList = [];
            for (var i = 0; i < snapshot.data!.docs.length; i++) {
              tweetList.add(TweetModel.fromJson(
                  snapshot.data!.docs[i] as Map<String, dynamic>));
            }
            return Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  LikeTweetModel reactTweetModel =
                      TweetsScreenCubit.get(context).getReactTweet(
                          tweetId: tweetList[index].tweetId!,
                          userId: tweetList[index].userId!) as LikeTweetModel;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TweetItem(
                      context: context,
                      tweet: tweetList[index],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
                itemCount: tweetList.length,
              ),
            );
          }
        },
      ),
    );
  }
}
