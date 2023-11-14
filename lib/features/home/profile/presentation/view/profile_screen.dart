import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/core/components/tweet_item.dart';
import 'package:social_app/core/constants.dart';
import 'package:social_app/core/models/react_tweet_model.dart';
import 'package:social_app/core/models/tweet_model.dart';
import 'package:social_app/core/styles/icon_broken.dart';
import 'package:social_app/features/home/home_page/presentation/controller/home_cubit/home_cubit.dart';
import 'package:social_app/features/home/posts/presentation/controller/tweets_screen_cubit.dart';
import 'package:social_app/features/home/profile/presentation/view/edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  CollectionReference tweets = FirebaseFirestore.instance.collection('tweets');

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.24,
                width: double.infinity,
              ),
              if (HomeCubit.userModel!.cover != null)
                Image.network(
                  HomeCubit.userModel!.cover!,
                  height: MediaQuery.sizeOf(context).height * 0.17,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              if (HomeCubit.userModel!.cover == null)
                Image.asset(
                  'assets/images/photo.jpg',
                  height: MediaQuery.sizeOf(context).height * 0.17,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.7),
                        child: const Icon(
                          IconBroken.Arrow___Left,
                          color: Colors.white,
                        ))),
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.7),
                          child: const Icon(
                            IconBroken.More_Circle,
                            color: Colors.white,
                          ))),
                ],
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  margin: const EdgeInsets.all(15),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(width: 4, color: Colors.white),
                    borderRadius: BorderRadius.circular(50),
                    image: HomeCubit.userModel!.image != null
                        ? DecorationImage(
                            opacity: 0.5,
                            colorFilter: const ColorFilter.mode(
                                Colors.black, BlendMode.colorDodge),
                            image: NetworkImage(HomeCubit.userModel!.image!),
                            fit: BoxFit.cover,
                          )
                        : const DecorationImage(
                            opacity: 0.5,
                            colorFilter: ColorFilter.mode(
                                Colors.black, BlendMode.colorDodge),
                            image: AssetImage('assets/images/profile.jpg'),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfile(),
                        ));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(15),
                    width: 110,
                    height: 35,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      'Edit Profile',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15).copyWith(top: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  HomeCubit.userModel!.name!,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      overflow: TextOverflow.ellipsis),
                ),
                Text(
                  HomeCubit.userModel!.email!,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'bio: Software Engineer',
                  style:
                      TextStyle(fontSize: 19, overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          IconBroken.Folder,
                          size: 15,
                        ),
                        Text(
                          ' Born ${HomeCubit.userModel!.date}',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                    // const SizedBox(
                    //   width: 5,
                    // ),
                    // Row(
                    //   children: [
                    //     const Icon(
                    //       IconBroken.Add_User,
                    //       size: 15,
                    //     ),
                    //     Text(
                    //       ' Joined Sep 24, 2023',
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
                // const SizedBox(
                //   height: 10,
                // ),
                // Row(
                //   children: [
                //     Row(
                //       children: [
                //         const Text(
                //           '1057 ',
                //           style: TextStyle(
                //               fontSize: 16,
                //               fontWeight: FontWeight.bold,
                //               overflow: TextOverflow.ellipsis),
                //         ),
                //         Text(
                //           'Following',
                //           style: TextStyle(
                //               fontSize: 16,
                //               color: Colors.grey[600],
                //               fontWeight: FontWeight.bold,
                //               overflow: TextOverflow.ellipsis),
                //         ),
                //       ],
                //     ),
                //     const SizedBox(
                //       width: 10,
                //     ),
                //     Row(
                //       children: [
                //         const Text(
                //           '1057 ',
                //           style: TextStyle(
                //               fontSize: 16,
                //               fontWeight: FontWeight.bold,
                //               overflow: TextOverflow.ellipsis),
                //         ),
                //         Text(
                //           'Following',
                //           style: TextStyle(
                //               fontSize: 16,
                //               color: Colors.grey[600],
                //               fontWeight: FontWeight.bold,
                //               overflow: TextOverflow.ellipsis),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
          TabBar(
            controller: tabController,
            isScrollable: true,
            tabs: const [
              Tab(
                text: 'Tweets',
              ),
              // Tab(
              //   text: 'Replies',
              // ),
              // Tab(
              //   text: 'Highlights',
              // ),
              Tab(
                text: 'Media',
              ),
              Tab(
                text: 'Likes',
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: tweets.orderBy('tweetDate', descending: true).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child:
                          CircularProgressIndicator()); // Show a loading indicator while data is loading.
                } else if (snapshot.hasError) {
                  return const Center(
                      child: Text('Error loading posts')); // Handle errors.
                } else {
                  List<TweetModel> tweetList = [];
                  for (var i = 0; i < snapshot.data!.docs.length; i++) {
                    var tweetModel =
                        TweetModel.fromJson(snapshot.data!.docs[i]);
                    if (tweetModel.userId == uId) {
                      tweetList.add(tweetModel);
                    }
                    // tweetList.add(TweetModel.fromJson(
                    //     snapshot.data!.docs[0].reference.collection('like')));
                  }
                  // tweetList[0].
                  return TabBarView(
                    controller: tabController,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return FutureBuilder(
                              future: snapshot.data!.docs[index].reference
                                  .collection('reacts')
                                  .doc(uId)
                                  .get(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container();
                                } else {
                                  bool likeValue = false;
                                  if (snapshot.hasData &&
                                      snapshot.data!.exists) {
                                    final data = snapshot.data!.data() as Map<
                                        String,
                                        dynamic>; // Cast to the expected type
                                    if (data['like'] != null) {
                                      likeValue = data['like']
                                          as bool; // Cast to bool if it's of that type
                                    }
                                  }
                                  // print(likeValue);

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: TweetItem(
                                      context: context,
                                      tweet: tweetList[index],
                                      likeValue:
                                          likeValue, // Pass the likeValue to the TweetItem
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
                          itemCount: tweetList.length,
                        ),
                      ),
                      Padding(
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
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container();
                                } else {
                                  bool likeValue = false;
                                  if (snapshot.hasData &&
                                      snapshot.data!.exists) {
                                    final data = snapshot.data!.data() as Map<
                                        String,
                                        dynamic>; // Cast to the expected type
                                    if (data['like'] != null) {
                                      likeValue = data['like']
                                          as bool; // Cast to bool if it's of that type
                                    }
                                  }
                                  // print(likeValue);

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: TweetItem(
                                      context: context,
                                      tweet: tweetList[index],
                                      likeValue:
                                          likeValue, // Pass the likeValue to the TweetItem
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
                          itemCount: tweetList.length,
                        ),
                      ),
                      Padding(
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
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container();
                                } else {
                                  bool likeValue = false;
                                  if (snapshot.hasData &&
                                      snapshot.data!.exists) {
                                    final data = snapshot.data!.data() as Map<
                                        String,
                                        dynamic>; // Cast to the expected type
                                    if (data['like'] != null) {
                                      likeValue = data['like']
                                          as bool; // Cast to bool if it's of that type
                                    }
                                  }
                                  // print(likeValue);

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: TweetItem(
                                      context: context,
                                      tweet: tweetList[index],
                                      likeValue:
                                          likeValue, // Pass the likeValue to the TweetItem
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
                          itemCount: tweetList.length,
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 10, bottom: 10),
                      //   child: ListView.separated(
                      //     itemBuilder: (context, index) {
                      //       LikeTweetModel reactTweetModel =
                      //           TweetsScreenCubit.get(context).getReactTweet(
                      //                   tweetId: tweetList[index].tweetId!,
                      //                   userId: tweetList[index].userId!)
                      //               as LikeTweetModel;
                      //       // final post =
                      //       //     PostData.posts[PostData.posts.length - index - 1];
                      //       return Padding(
                      //         padding:
                      //             const EdgeInsets.symmetric(horizontal: 20),
                      //         child: TweetItem(
                      //           context: context,
                      //           tweet: tweetList[index],
                      //           // reactTweetModel: reactTweetModel,
                      //         ),
                      //       );
                      //     },
                      //     separatorBuilder: (context, index) => Container(
                      //       margin: const EdgeInsets.symmetric(vertical: 15),
                      //       width: double.infinity,
                      //       height: 1,
                      //       color: Colors.grey[300],
                      //     ),
                      //     itemCount: tweetList.length,
                      //   ),
                      // ),
                    ],
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget Tweets(tweetList) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.separated(
        itemBuilder: (context, index) {
          LikeTweetModel reactTweetModel = TweetsScreenCubit.get(context)
              .getReactTweet(
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
}
