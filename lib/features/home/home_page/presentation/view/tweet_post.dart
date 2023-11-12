import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app/features/home/home_page/presentation/controller/home_cubit/home_cubit.dart';
import 'package:social_app/features/home/home_page/presentation/controller/tweets_cubit/tweets_cubit.dart';
import 'package:social_app/features/home/home_page/presentation/controller/tweets_cubit/tweets_states.dart';
import 'package:social_app/features/home/home_page/presentation/view/home_screen.dart';

class TweetNewPost extends StatefulWidget {
  const TweetNewPost({super.key});
  static const List<String> list = ['Public', 'Only Friends', 'Privet'];

  @override
  State<TweetNewPost> createState() => _TweetNewPostState();
}

class _TweetNewPostState extends State<TweetNewPost> {
  @override
  Widget build(BuildContext context) {
    String dropdownValue = TweetNewPost.list.first;
    var tweetTextController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => TweetsCubit(),
      child: BlocConsumer<TweetsCubit, TweetsStates>(
        listener: (context, state) {
          if (state is CreateTweetSuccessState) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
                (route) => false);
          }
        },
        builder: (context, state) {
          var cubit = TweetsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                InkWell(
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    if (cubit.tweetImage == null &&
                        formKey.currentState!.validate()) {
                      cubit.createTweet(
                          tweetText: tweetTextController.text,
                          tweetDate: DateTime.now().toString(),
                          tweetTime:
                              DateFormat('hh:mm a').format(DateTime.now()));
                    } else if (cubit.tweetImage != null) {
                      cubit.createTweetWithImage(
                          tweetText: tweetTextController.text,
                          tweetDate: DateTime.now().toString(),
                          tweetTime:
                              DateFormat('hh:mm a').format(DateTime.now()));
                    }
                  },
                  child: Container(
                    width: 80,
                    height: 30,
                    margin: const EdgeInsets.only(right: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50)),
                    child: const Text(
                      'Tweet',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (HomeCubit.userModel?.image != null)
                            CircleAvatar(
                              radius: 18,
                              backgroundImage: NetworkImage(
                                HomeCubit.userModel!.image!,
                              ),
                            ),
                          if (HomeCubit.userModel?.image == null)
                            const CircleAvatar(
                              radius: 20,
                              backgroundImage:
                                  AssetImage('assets/images/profile.jpg'),
                            ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.blue),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: DropdownButton(
                                      value: dropdownValue,
                                      isExpanded: true,
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 5),
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.blue,
                                      ),
                                      elevation: 0,
                                      underline: const SizedBox(
                                        height: 0,
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          dropdownValue = value!;
                                        });
                                      },
                                      // dropdownColor: Colors.blue[300],

                                      borderRadius: BorderRadius.circular(25),
                                      items: TweetNewPost.list
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,
                                              style: const TextStyle(
                                                color: Colors.blue,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700,
                                              )),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.photo_outlined,
                                      size: 30,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      cubit.addTweetImage();
                                    },
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: tweetTextController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Write anything';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        hintText: "What's happening?",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                    if (cubit.tweetImage != null)
                                      Expanded(
                                          child: Image(
                                              image: FileImage(
                                                  cubit.tweetImage!))),
                                  ],
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.grey[300],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.public,
                          color: Colors.blue,
                          size: 27,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Everyone can reply',
                          style: TextStyle(color: Colors.blue, fontSize: 17),
                        )
                      ],
                    ),
                  ),
                  // Divider(
                  //   height: 1,
                  //   color: Colors.grey[300],
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 20, vertical: 15),
                  //   child: Row(
                  //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       IconButton(
                  //         icon: const Icon(
                  //           Icons.photo_outlined,
                  //           size: 30,
                  //           color: Colors.blue,
                  //         ),
                  //         onPressed: () {},
                  //       ),
                  //       const SizedBox(
                  //         width: 20,
                  //       ),
                  //       IconButton(
                  //         icon: const Icon(
                  //           Icons.gif_box_outlined,
                  //           size: 30,
                  //           color: Colors.blue,
                  //         ),
                  //         onPressed: () {},
                  //       ),
                  //       const SizedBox(
                  //         width: 20,
                  //       ),
                  //       IconButton(
                  //         icon: const Icon(
                  //           IconBroken.More_Square,
                  //           size: 30,
                  //           color: Colors.blue,
                  //         ),
                  //         onPressed: () {},
                  //       ),
                  //       const SizedBox(
                  //         width: 20,
                  //       ),
                  //       IconButton(
                  //         icon: const Icon(
                  //           IconBroken.Location,
                  //           size: 30,
                  //           color: Colors.blue,
                  //         ),
                  //         onPressed: () {},
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
