import 'package:flutter/material.dart';
import 'package:social_app/core/components/appbar.dart';
import 'package:social_app/core/styles/icon_broken.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCenterScreen extends StatelessWidget {
  HelpCenterScreen({super.key});
  final Uri _url = Uri.parse('https://flutter.dev');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponents(context, title: 'Help Center', username: false),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HelpCenterItem(
            //   context,
            //   icon: IconBroken.User,
            //   text1: 'Facebook',
            //   text2: 'Click here to visit the facebook',
            //   urlToWebsite: 'https://www.facebook.com/SamehBrakatAboStite',
            // )
            Center(
              child: ElevatedButton(
                onPressed: _launchUrl,
                child: Text('Show Flutter homepage'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  // Widget HelpCenterItem(
  //   context, {
  //   required IconData icon,
  //   required String text1,
  //   required String text2,
  //   required String urlToWebsite,
  // }) {
  //   return InkWell(
  //     highlightColor: Colors.transparent,
  //     splashColor: Colors.transparent,
  //     onTap: () async {
  //       final Uri url = Uri.parse('https://flutter.dev');
  //       if (!await launchUrl(url)) {
  //         throw Exception('Could not launch $url');
  //       }
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.all(15),
  //       child: Row(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Icon(icon),
  //           SizedBox(
  //             width: 20,
  //           ),
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   text1,
  //                   style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19),
  //                 ),
  //                 Text(
  //                   text2,
  //                   style: TextStyle(
  //                     fontSize: 16,
  //                     color: Colors.grey[600],
  //                     fontWeight: FontWeight.w400,
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
