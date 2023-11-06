import 'package:flutter/material.dart';
import 'package:social_app/core/components/appbar.dart';
import 'package:social_app/core/components/icon_title_info.dart';
import 'package:social_app/core/styles/icon_broken.dart';
import 'package:social_app/features/home/settings/presentation/view/account_information.dart';
import 'package:social_app/features/home/settings/presentation/view/change_password.dart';
import 'package:social_app/features/home/settings/presentation/view/settings_screen.dart';

class AccountSettingScreen extends StatelessWidget {
  const AccountSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponents(context, title: 'Your Account'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15).copyWith(bottom: 0),
              child: Text(
                "See information about your account, download an archive of your data, or learn about your account deactivation options.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            IconAndTitleAndInfo(
              context,
              icon: IconBroken.Profile,
              text1: 'Account information',
              text2:
                  'See your account information like your phone number and email address.',
              navigatTo: AccountInformation(),
            ),
            IconAndTitleAndInfo(
              context,
              icon: IconBroken.Lock,
              text1: 'Change your password',
              text2: "Change your password at any time",
              navigatTo: ChangePassword(),
            ),
            IconAndTitleAndInfo(
              context,
              icon: IconBroken.Heart,
              text1: 'Deactivate Account',
              text2: 'Find out how you can deactivate your account.',
              navigatTo: SettingScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
