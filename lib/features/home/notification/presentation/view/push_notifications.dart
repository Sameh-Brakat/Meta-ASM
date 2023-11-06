import 'package:flutter/material.dart';
import 'package:social_app/core/styles/icon_broken.dart';

class PushNotifications extends StatelessWidget {
  const PushNotifications({super.key});

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
          'Push notifications',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        actions: [
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.transparent),
            child: Switch(
              materialTapTargetSize: MaterialTapTargetSize.padded,
              value: true,
              onChanged: (value) {
                value != value;
              },
              activeColor: Colors.blue,
              inactiveThumbColor: Colors.grey,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tweets from people you follow',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Item('Tweets', '0 people'),
              SizedBox(
                height: 15,
              ),
              Text(
                'Related to you and your Tweets',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Item('Mentions and replies', 'Tailored for you'),
              Item('Retweets', 'Tailored for you'),
              Item('Likes', 'Tailored for you'),
              ItemAndCheck('Photo tags'),
              ItemAndCheck('Moments'),
              SizedBox(
                height: 15,
              ),
              Text(
                'Followers and contacts',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              ItemAndCheck('New followers'),
              ItemAndCheck('Contact joins Twitter'),
              SizedBox(
                height: 15,
              ),
              Text(
                'Direct Messages',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              ItemAndCheck('Direct Messages'),
              Item('Message reactions', 'Your own Message'),
              SizedBox(
                height: 15,
              ),
              Text(
                'Recommendations from Twitter',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              ItemAndCheck('Topics'),
              ItemAndCheck('Recommendations'),
              ItemAndCheck('Spaces'),
              ItemAndCheck('Other live broadcasts'),
              SizedBox(
                height: 15,
              ),
              Text(
                'News from Twitter',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              ItemAndCheck('News / Sports'),
              ItemAndCheck('First look at new features'),
              SizedBox(
                height: 15,
              ),
              Text(
                'Emergency alerts',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              ItemAndCheck('Crisis and emergency alerts'),
              SizedBox(
                height: 15,
              ),
              Text(
                'Twitter for Professionals',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              ItemAndCheck('Ads campaigns'),
            ],
          ),
        ),
      ),
    );
  }

  Widget Item(text1, text2) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text1,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
            ),
            Text(
              text2,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      );
  Widget ItemAndCheck(text) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.check_box,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      );
}
