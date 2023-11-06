import 'package:flutter/material.dart';
import 'package:social_app/core/components/appbar.dart';
import 'package:social_app/core/components/text_field_item.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool texted1 = false;
  bool texted2 = false;
  bool texted3 = false;

  var currentPassController = TextEditingController();

  var newPassController = TextEditingController();

  var confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponents(context, title: 'Change Password'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          TextFieldItem(
            'Current password',
            controller: currentPassController,
            onChanged: (value) {
              setState(() {
                if (value.isEmpty) {
                  texted1 = false;
                } else {
                  texted1 = true;
                }
              });
            },
          ),
          TextFieldItem(
            'New password',
            controller: newPassController,
            onChanged: (value) {
              setState(() {
                if (value.isEmpty) {
                  texted2 = false;
                } else {
                  texted2 = true;
                }
              });
            },
          ),
          TextFieldItem(
            'Confirm password',
            controller: confirmPassController,
            onChanged: (value) {
              setState(() {
                if (value.isEmpty) {
                  texted3 = false;
                } else {
                  texted3 = true;
                }
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.6,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: texted1 == true && texted2 == true && texted3 == true
                        ? Colors.blue
                        : Colors.blue.withOpacity(0.6),
                  ),
                  child: Text(
                    'Update password',
                    style: TextStyle(
                      color:
                          texted1 == true && texted2 == true && texted3 == true
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forget password?',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
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
