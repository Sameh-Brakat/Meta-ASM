import 'package:flutter/material.dart';
import 'package:social_app/core/components/appbar.dart';
import 'package:social_app/core/utils/cashe_helper.dart';
import 'package:social_app/features/authentication/login/presentation/view/login_screen.dart';
import 'package:social_app/features/home/settings/presentation/view/change_email.dart';
import 'package:social_app/features/home/settings/presentation/view/change_phone.dart';
import 'package:social_app/features/home/settings/presentation/view/change_username.dart';

class AccountInformation extends StatelessWidget {
  const AccountInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponents(context, title: 'Account Information'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Item(
              'Username',
              '@samehelsayedbarakat',
              context,
              navigatTo: ChangeUsername(),
            ),
            Item(
              'Phone',
              '+20 122 189 0920',
              context,
              navigatTo: ChangePhone(),
            ),
            Item(
              'Email',
              'sameh13652@gmail.com',
              context,
              navigatTo: ChangeEmail(),
            ),
            // Item(
            //   'Country',
            //   'Egypt',
            //   context,
            //   navigatTo: ChangeUsername(),
            // ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: InkWell(
                onTap: () {
                  CacheHelper.removeData(key: 'uId').then((value) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (route) => false);
                  });
                },
                child: Text(
                  'Log out',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 19,
                    color: Colors.red,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget Item(text1, text2, context, {required Widget navigatTo}) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => navigatTo,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
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
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
