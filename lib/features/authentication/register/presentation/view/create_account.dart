import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app/core/components/text_field_item.dart';
import 'package:social_app/core/styles/icon_broken.dart';
import 'package:social_app/features/authentication/login/presentation/view/login_screen.dart';
import 'package:social_app/features/authentication/register/presentation/controller/create_account_cubit.dart';
import 'package:social_app/features/authentication/register/presentation/controller/create_account_states.dart';
import 'package:social_app/features/home/home_page/presentation/view/home_screen.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool nametexted = false;
  bool emailtexted = false;
  bool passwordtexted = false;
  bool passSecure = true;

  var nameController = TextEditingController();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is CreateUserSuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (route) => false);
                  },
                  icon: const Icon(IconBroken.Arrow___Left)),
              centerTitle: true,
              title: const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/logo.png'),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Text(
                          'Create your account',
                          style: TextStyle(
                            fontSize: 29,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(
                          height: 120,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFieldAuth(
                              'your name',
                              onChanged: (value) {
                                setState(() {
                                  if (value.isEmpty) {
                                    nametexted = false;
                                  } else {
                                    nametexted = true;
                                  }
                                });
                              },
                              controller: nameController,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            TextFieldAuth(
                              'your email',
                              onChanged: (value) {
                                setState(() {
                                  if (value.isEmpty) {
                                    emailtexted = false;
                                  } else {
                                    emailtexted = true;
                                  }
                                });
                              },
                              controller: emailController,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            TextFormField(
                              controller: passwordController,
                              obscureText: passSecure,
                              onChanged: (value) {
                                setState(() {
                                  if (value.isEmpty) {
                                    passwordtexted = false;
                                  } else {
                                    passwordtexted = true;
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    passSecure
                                        ? Icons.visibility_off
                                        : Icons.visibility,
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
                            const SizedBox(
                              height: 25,
                            ),
                            TextFormField(
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.parse('2003-01-01'),
                                  firstDate: DateTime.parse('1950-01-01'),
                                  lastDate: DateTime.parse(
                                      '2005-01-01'), // what prob here
                                ).then((value) {
                                  if (value != null) {
                                    dateController.text =
                                        DateFormat.yMMMd().format(value);
                                  } else {
                                    dateController.clear();
                                  }
                                });
                              },
                              controller: dateController,
                              keyboardType: TextInputType.none,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Date Must not be Empty';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Date of birth',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () async {
                      if (nametexted == true &&
                          emailtexted == true &&
                          passwordtexted == true) {
                        RegisterCubit.get(context).userRegister(
                          context,
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          date: dateController.text,
                        );
                      }
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.6,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: nametexted == true &&
                                emailtexted == true &&
                                passwordtexted == true
                            ? Colors.blue
                            : Colors.blue.withOpacity(0.6),
                      ),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: nametexted == true &&
                                  emailtexted == true &&
                                  passwordtexted == true
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
