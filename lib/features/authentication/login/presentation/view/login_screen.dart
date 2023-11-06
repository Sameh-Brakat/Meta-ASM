import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_app/core/components/footer.dart';
import 'package:social_app/core/components/text_field_item.dart';
import 'package:social_app/core/components/toast.dart';
import 'package:social_app/core/utils/cashe_helper.dart';
import 'package:social_app/features/authentication/login/presentation/view/otp_login.dart';
import 'package:social_app/features/home/home_page/presentation/view/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool texted = false;
  bool next = false;
  bool passSecure = true;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CircleAvatar(
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
                Text(
                  next == true
                      ? 'Enter your password'
                      : 'To get started, first enter your phone, email, or @username',
                  style: GoogleFonts.cairo(
                      fontSize: 23, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldAuth(
                  'phone, email, or username',
                  controller: emailController,
                  onChanged: (value) {
                    setState(() {
                      if (value.isEmpty) {
                        texted = false;
                      } else {
                        texted = true;
                      }
                    });
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                if (next == true)
                  TextFormField(
                    controller: passwordController,
                    obscureText: passSecure,
                    onChanged: (value) {
                      setState(() {
                        if (value.isEmpty) {
                          texted = false;
                        } else {
                          texted = true;
                        }
                      });
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          passSecure ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            passSecure = !passSecure;
                          });
                        },
                      ),
                      hintText: 'Password',
                      border: const OutlineInputBorder(),
                    ),
                  ),
              ],
            ),
          ),
          const Spacer(),
          Footer(
            context,
            'Create account',
            'Log in',
            firstTerm: true,
            inLogin: true,
            texted: texted,
            navigatTo: const OTPLoginScreen(),
            nxtInAuth: next,
            nxtOnTap: texted == true
                ? () {
                    setState(() {
                      next = true;
                    });
                  }
                : null,
            onsubmit: () async {
              try {
                await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text)
                    .then((value) {
                  CacheHelper.saveData(key: 'uId', value: value.user!.uid)
                      .then((value) {
                    Toastt(
                        message: "Sign in Successfully",
                        state: ToastStates.SUCCESS);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                      (route) => false,
                    );
                  });
                });
              } on FirebaseAuthException catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.message.toString())));
                print('Failed with error code: ${e.code}');
                print(e.email);
              } catch (e) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
          ),
        ],
      ),
    );
  }
}
