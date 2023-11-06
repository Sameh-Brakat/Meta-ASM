import 'package:flutter/material.dart';
import 'package:social_app/core/components/footer.dart';
import 'package:social_app/core/components/text_field_item.dart';

Widget ChangeInfo(
  context, {
  required String title,
  required String info,
  required TextEditingController controller,
  required bool texted,
  required Widget navigatTo,
}) {
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: CircleAvatar(
        radius: 20,
        backgroundImage: AssetImage('assets/images/logo.png'),
      ),
    ),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                info,
                style: TextStyle(color: Colors.grey[600], fontSize: 17),
              ),
              SizedBox(
                height: 30,
              ),
              TextFieldAuth(
                'New phone number',
                controller: controller,
                onChanged: (value) {
                  if (value.isEmpty) {
                    texted = false;
                  } else {
                    texted = true;
                  }
                },
              ),
            ],
          ),
        ),
        Spacer(),
        Footer(
          context,
          'Cancel',
          'Next',
          inLogin: false,
          texted: texted,
          navigatTo: navigatTo,
          nxtInAuth: false,
          nxtOnTap: texted == true ? () {} : null,
        ),
      ],
    ),
  );
}
