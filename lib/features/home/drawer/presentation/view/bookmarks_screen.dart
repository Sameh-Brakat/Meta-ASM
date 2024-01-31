import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/core/components/shimmerLoading.dart';
import 'package:social_app/core/components/tweet_item.dart';
import 'package:social_app/core/constants.dart';
import 'package:social_app/core/models/react_tweet_model.dart';
import 'package:social_app/core/models/tweet_model.dart';
import 'package:social_app/features/home/home_page/presentation/view/home_screen.dart';
import 'package:social_app/features/home/posts/presentation/controller/tweets_screen_cubit.dart';

class BookMarksScreen extends StatefulWidget {
  const BookMarksScreen({super.key});

  @override
  State<BookMarksScreen> createState() => _BookMarksScreenState();
}

class _BookMarksScreenState extends State<BookMarksScreen> {
  CollectionReference bookmarksCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(uId)
      .collection('bookmarks');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Bookmarks',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: bookmarksCollection
            .orderBy('tweetDate', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Show a loading indicator while data is loading.
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Error loading posts')); // Handle errors.
          } else {
            List<TweetModel> bookMarksList = [];
            for (var i = 0; i < snapshot.data!.docs.length; i++) {
              bookMarksList.add(TweetModel.fromJson(snapshot.data!.docs[i]));
            }
            return Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return FutureBuilder(
                    future: snapshot.data!.docs[index].reference
                        .collection('reacts')
                        .doc(uId)
                        .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ShimmerLoading(context);
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TweetItem(
                            context: context,
                            tweet: bookMarksList[
                                index], // Pass the likeValue to the TweetItem
                          ),
                        );
                      }
                    },
                  );
                },
                separatorBuilder: (context, index) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
                itemCount: bookMarksList.length,
              ),
            );
          }
        },
      ),
    );
  }
}
