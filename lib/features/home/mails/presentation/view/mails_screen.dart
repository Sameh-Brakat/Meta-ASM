import 'package:flutter/material.dart';
import 'package:social_app/core/styles/icon_broken.dart';

class MailsScreen extends StatelessWidget {
  const MailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return MessageItem();
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemCount: 3,
    );
  }

  Widget MessageItem() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/profile.jpg'),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 110,
                      child: Text(
                        'Sameh Barakat',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    const Icon(
                      Icons.verified,
                      color: Colors.blue,
                      size: 15,
                    ),
                    SizedBox(
                      width: 70,
                      child: Text(
                        '@samehelsayedbarakat',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      '15 Mar 22',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                const Text(
                  'السلام عليكم ورحمة الله وبركاته',
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
