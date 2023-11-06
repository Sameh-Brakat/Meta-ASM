import 'package:flutter/material.dart';
import 'package:social_app/core/components/tweet_preview.dart';
import 'package:social_app/core/models/tweet_model.dart';
import 'package:social_app/core/styles/icon_broken.dart';

Widget TweetItem({
  required TweetModel tweet,
  required context,
}) =>
    Row(
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
                    tweet.tweetDate!,
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
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(IconBroken.Message),
                      Text(" ${tweet.numberOfComments}"),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(IconBroken.Arrow___Right_Circle),
                      Text(' ${tweet.numberOfRetweets}'),
                    ],
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        const Icon(IconBroken.Heart),
                        Text(' ${tweet.numberOfLikes}'),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(IconBroken.Download),
                      Text(' ${tweet.numberOfViews}'),
                    ],
                  ),
                  const Icon(IconBroken.Send),
                ],
              ),
            ],
          ),
        ),
      ],
    );
