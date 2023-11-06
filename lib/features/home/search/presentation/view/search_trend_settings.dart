import 'package:flutter/material.dart';
import 'package:social_app/core/styles/icon_broken.dart';

class SearchTrendSettings extends StatelessWidget {
  const SearchTrendSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trends'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Trends Location',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "You can see what's trending in a specific location by selecting which one shows up in your Trending tab.",
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
