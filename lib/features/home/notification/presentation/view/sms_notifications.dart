import 'package:flutter/material.dart';
import 'package:social_app/core/styles/icon_broken.dart';

class SMSNotifications extends StatelessWidget {
  const SMSNotifications({super.key});

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
          'SMS notifications',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Related to you and your Tweets',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              ItemAndCheck('Direct Message'),
              Item('Likes', 'Off'),
              ItemAndCheck('New followers'),
              Item('Mentions and replies', 'Off'),
              Item('Retweets', 'Off'),
              Item('Tweets', 'Off'),
              SizedBox(
                height: 15,
              ),
              Text(
                'From Twitter',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              ItemAndCheck('News / Sports'),
              ItemAndCheck('Recommendations'),
              ItemAndCheck('Crisis emergercy alerts'),
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
