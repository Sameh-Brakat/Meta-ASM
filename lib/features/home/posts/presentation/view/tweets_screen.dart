import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/components/tweet_item.dart';
import 'package:social_app/core/models/tweet_model.dart';
import 'package:social_app/features/home/posts/presentation/controller/tweets_screen_cubit.dart';
import 'package:social_app/features/home/posts/presentation/controller/tweets_screen_states.dart';

class TweetsScreen extends StatefulWidget {
  const TweetsScreen({super.key});

  @override
  State<TweetsScreen> createState() => _TweetsScreenState();
}

class _TweetsScreenState extends State<TweetsScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  CollectionReference tweets = FirebaseFirestore.instance.collection('tweets');

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TweetsScreenCubit(),
      child: BlocConsumer<TweetsScreenCubit, TweetsScreenStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                toolbarHeight: 0,
                bottom: TabBar(
                  controller: tabController,
                  tabs: const [
                    Tab(
                      text: 'For you',
                    ),
                    Tab(
                      text: 'Following',
                    ),
                  ],
                ),
              ),
              body: StreamBuilder<QuerySnapshot>(
                stream: tweets.orderBy('tweetDate').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Show a loading indicator while data is loading.
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text('Error loading posts')); // Handle errors.
                  } else {
                    // print(snapshot.data!.docs.first.data());

                    print(snapshot.data!.docs[0].data());
                    snapshot.data!.docs.map((DocumentSnapshot tweetDocument) {
                      Map<String, dynamic> tweetData =
                          tweetDocument.data() as Map<String, dynamic>;
                      print(tweetData);

                      // Get the tweet's document reference.
                      DocumentReference tweetReference =
                          tweetDocument.reference;

                      // Access the "likes" subcollection for the tweet document.
                      CollectionReference likesCollection =
                          tweetDocument.reference.collection('likes');
                    });
                    print(
                        "This is ref ${snapshot.data!.docs[0].reference.collection('like').id}");

                    List<TweetModel> tweetList = [];
                    for (var i = 0; i < snapshot.data!.docs.length; i++) {
                      tweetList
                          .add(TweetModel.fromJson(snapshot.data!.docs[i]));
                      // tweetList.add(TweetModel.fromJson(
                      //     snapshot.data!.docs[0].reference.collection('like')));
                    }
                    // tweetList[0].
                    return TabBarView(
                      controller: tabController,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              // final post = PostData.posts[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              // final post =
                              //     PostData.posts[PostData.posts.length - index - 1];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
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
                        ),
                      ],
                    );
                  }
                },
              )
              // FutureBuilder(
              //   future: postData.loadPosts(),
              //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return const CircularProgressIndicator(); // Show a loading indicator while data is loading.
              //     } else if (snapshot.hasError) {
              //       return const Center(
              //           child: Text('Error loading posts')); // Handle errors.
              //     } else {

              //     }
              //   },
              // ),
              );
        },
      ),
    );
  }
}
