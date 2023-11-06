import 'package:flutter/material.dart';
import 'package:social_app/core/styles/icon_broken.dart';

class MutedNotifications extends StatelessWidget {
  const MutedNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mute notifications from people',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
            SizedBox(
              height: 15,
            ),
            Item("You don't follow"),
            Item("Who don't follow you"),
            Item("With a new account"),
            Item("Who have a default profile photo"),
            Item("Who haven't confirmed their email"),
            Item("Who haven't confirmed their phone number"),
            SizedBox(
              height: 30,
            ),
            Text(
              "These filters will not affect notifications from people you follow.",
              style: TextStyle(color: Colors.grey[600], fontSize: 15),
            )
          ],
        ),
      ),
    );
  }

  Widget Item(text) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
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
