import 'package:flutter/material.dart';
import 'package:social_app/core/styles/icon_broken.dart';

class EmailNotifications extends StatelessWidget {
  const EmailNotifications({super.key});

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
          'Email notifications',
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
                'Related to you and your Tweets',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              ItemAndCheck('New notifications'),
              ItemAndCheck('Direct Messages'),
              ItemAndCheck('Tweets emailed to you'),
              SizedBox(
                height: 15,
              ),
              Text(
                'From your network',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Item('Top Tweets and Stories', 'Periodically'),
              Item('Updates about the performance of your Tweets', 'Off'),
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
              ItemAndCheck(
                  'News about updates to Twitter products and features'),
              ItemAndCheck('Tips on getting more out of Twitter'),
              ItemAndCheck(
                  "Things you've missed since you last logged into Twitter"),
              ItemAndCheck(
                  'News about Twitter on partner products and other third-party services'),
              ItemAndCheck('Participation in Twitter research surveys'),
              ItemAndCheck('Suggestions for recommended accounts'),
              ItemAndCheck('Suggestions based on your recent follows'),
              ItemAndCheck('Tips on Twitter business products'),
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
