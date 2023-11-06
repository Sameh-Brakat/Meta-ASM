import 'package:flutter/material.dart';
import 'package:social_app/core/styles/icon_broken.dart';
import 'package:social_app/features/home/notification/presentation/view/filters_screen.dart';

class MessagesSettings extends StatelessWidget {
  const MessagesSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(IconBroken.Arrow___Left)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Messages Settings',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              '@samehelsayedbarakat',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis),
            )
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15).copyWith(bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Control Who can message you',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Depending on the setting you select, different people can send you a direct message.',
                  style: TextStyle(color: Colors.grey[600], fontSize: 15),
                ),
                SizedBox(
                  height: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MessageSettingsItem(
                        'Allow messages only from people you follow',
                        "You won't receive any message requests"),
                    MessageSettingsItem(
                        "Allow message requests only from Verified users",
                        "People you follow will still be able to message you"),
                    MessageSettingsItem("Allow message requests from everyone",
                        "People you follow will still be able to message you"),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(15).copyWith(top: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Other controls',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Send read receipts',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          Text(
                            "Let people you're messaging with know when you've seen their messages. Read receipts are not shown on message requests. Learn more",
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Theme(
                      data:
                          ThemeData(unselectedWidgetColor: Colors.transparent),
                      child: Switch(
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        value: true,
                        onChanged: (value) {
                          value != value;
                        },
                        activeColor: Colors.blue,
                        inactiveThumbColor: Colors.grey,
                        // splashRadius: 20,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget MessageSettingsItem(text1, text2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text1,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  text2,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.grey[500],
                  ),
                )
              ],
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(50)),
                child: Icon(
                  Icons.circle,
                  color: Colors.blue,
                  size: 17,
                ),
              ))
        ],
      ),
    );
  }
}
