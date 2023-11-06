import 'package:flutter/material.dart';
import 'package:social_app/features/home/settings/presentation/view/components/change_info.dart';
import 'package:social_app/features/home/settings/presentation/view/settings_screen.dart';

class ChangeEmail extends StatelessWidget {
  ChangeEmail({super.key});
  bool texted = false;
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeInfo(
      context,
      title: 'Add an Email',
      info:
          "Enter the email address you'd like to associate with ycur ASM account, Your email is not displayed Tn your public profile on ASM.",
      controller: emailController,
      texted: texted,
      navigatTo: const SettingScreen(),
    );
  }
}
