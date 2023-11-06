import 'package:flutter/material.dart';
import 'package:social_app/core/components/appbar.dart';
import 'package:social_app/core/components/icon_title_info.dart';
import 'package:social_app/core/styles/icon_broken.dart';
import 'package:social_app/features/home/notification/presentation/view/notification_screen.dart';
import 'package:social_app/features/home/notification/presentation/view/notifications_settings.dart';
import 'package:social_app/features/home/settings/presentation/view/account_settings.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponents(context, title: 'Settings'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            IconAndTitleAndInfo(context,
                icon: IconBroken.Profile,
                text1: 'Your account',
                text2:
                    'See information about your account, download an archive of your data, or learn about your account deactivation options.',
                navigatTo: AccountSettingScreen()),
            // IconAndTitleAndInfo(context,
            //     icon: IconBroken.Lock,
            //     text1: 'Security',
            //     text2:
            //         "Manage your account's security and keep track of your account's usage including apps that you have connected to your account.",
            //     navigatTo: AccountSettingScreen()),
            IconAndTitleAndInfo(context,
                icon: IconBroken.Notification,
                text1: 'Notifications',
                text2:
                    'Select the kinds of notifications you get about your activities, interests, and recommendations.',
                navigatTo: NotificationsSettings()),
          ],
        ),
      ),
    );
  }
}
