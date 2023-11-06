import 'package:flutter/material.dart';
import 'package:social_app/features/home/settings/presentation/view/components/change_info.dart';
import 'package:social_app/features/home/settings/presentation/view/settings_screen.dart';

class ChangePhone extends StatelessWidget {
  ChangePhone({super.key});
  bool texted = false;
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeInfo(
      context,
      title: 'Change Phone',
      info:
          "Your current phone number is +201221890920. What would you like to update it to?",
      controller: phoneController,
      texted: texted,
      navigatTo: SettingScreen(),
    );
  }
}
