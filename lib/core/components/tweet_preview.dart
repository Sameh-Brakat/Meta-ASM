import 'package:flutter/material.dart';
import 'package:social_app/core/models/tweet_model.dart';
import 'package:social_app/core/styles/icon_broken.dart';

class TweetPreview extends StatelessWidget {
  TweetPreview({super.key, required this.tweet});
  TweetModel tweet;
  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 10),
              child: ListView(
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
                            backgroundImage:
                                AssetImage('assets/images/profile.jpg')),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                tweet.name!,
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
                        tweet.tweetDate!,
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
                      Row(
                        children: [
                          Text(
                            '${tweet.numberOfRetweets} ',
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          Text(
                            'Retweets',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            '${tweet.numberOfQuotes} ',
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          Text(
                            'Quotes',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            '${tweet.numberOfLikes} ',
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          Text(
                            'Likes',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
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
                      Row(
                        children: [
                          Text(
                            '${tweet.numberOfBookmarks} ',
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          Text(
                            'Bookmarks',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Divider(
                    color: Colors.grey[300],
                    height: 1,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            IconBroken.Message,
                            size: 30,
                            color: Colors.black,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(
                            IconBroken.Arrow___Up_Square,
                            size: 30,
                            color: Colors.black,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(
                            IconBroken.Heart,
                            size: 30,
                            color: Colors.black,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(
                            IconBroken.Download,
                            size: 30,
                            color: Colors.black,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(
                            IconBroken.Send,
                            size: 30,
                            color: Colors.black,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  )
                ],
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
                  decoration: const InputDecoration(
                      hintText: 'Tweet your reply', border: InputBorder.none),
                ),
              ),
              IconButton(
                icon: const Icon(
                  IconBroken.Camera,
                  color: Colors.blue,
                  size: 27,
                ),
                onPressed: () {},
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
