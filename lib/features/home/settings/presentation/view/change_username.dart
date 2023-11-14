import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/core/components/appbar.dart';
import 'package:social_app/core/components/text_field_item.dart';
import 'package:social_app/features/home/home_page/presentation/controller/home_cubit/home_cubit.dart';

class ChangeUsername extends StatelessWidget {
  ChangeUsername({super.key});

  var usernameController =
      TextEditingController(text: HomeCubit.userModel?.email);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBarComponents(context, title: 'Change username', username: false),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15).copyWith(bottom: 30, top: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Current',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  HomeCubit.userModel!.email!,
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          TextFieldItem('New', controller: usernameController),
          const Spacer(),
          const Divider(),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(HomeCubit.userModel?.uId)
                    .update({'email': usernameController.text}).then((value) {
                  HomeCubit.get(context).getUser();
                }).catchError((e) {
                  print(e);
                });
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Container(
                  height: 35,
                  width: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
