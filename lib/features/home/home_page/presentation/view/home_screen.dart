import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/styles/icon_broken.dart';
import 'package:social_app/core/utils/cashe_helper.dart';
import 'package:social_app/features/authentication/login/presentation/view/login_screen.dart';
import 'package:social_app/features/home/drawer/presentation/view/blue_screen.dart';
import 'package:social_app/features/home/drawer/presentation/view/bookmarks_screen.dart';
import 'package:social_app/features/home/drawer/presentation/view/list_screen.dart';
import 'package:social_app/features/home/drawer/presentation/view/spaces_screen.dart';
import 'package:social_app/features/home/home_page/presentation/controller/home_cubit/home_cubit.dart';
import 'package:social_app/features/home/home_page/presentation/controller/home_cubit/home_states.dart';
import 'package:social_app/features/home/home_page/presentation/view/tweet_post.dart';
import 'package:social_app/features/home/mails/presentation/view/messages_settings.dart';
import 'package:social_app/features/home/notification/presentation/view/notifications_settings.dart';
import 'package:social_app/features/home/profile/presentation/view/profile_screen.dart';
import 'package:social_app/features/home/search/presentation/view/search_trend_settings.dart';
import 'package:social_app/features/home/settings/presentation/view/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getUser(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          UserModel? user = HomeCubit.userModel;
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              leading: Builder(
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: const CircleAvatar(
                          radius: 5,
                          backgroundImage: AssetImage(
                            'assets/images/profile.jpg',
                          )),
                    ),
                  );
                },
              ),
              centerTitle: cubit.currentIndex == 0 ? true : false,
              title: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  HomeCubit.get(context).navigatorToNewScreen(context);
                },
                child: cubit.title[cubit.currentIndex],
              ),
              actions: [
                if (cubit.currentIndex == 1)
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchTrendSettings(),
                            ));
                      },
                      icon: const Icon(
                        IconBroken.Setting,
                        color: Colors.black,
                        size: 27,
                      )),
                if (cubit.currentIndex == 2)
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const NotificationsSettings(),
                            ));
                      },
                      icon: const Icon(
                        IconBroken.Setting,
                        color: Colors.black,
                        size: 27,
                      )),
                if (cubit.currentIndex == 3)
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MessagesSettings(),
                            ));
                      },
                      icon: const Icon(
                        IconBroken.Setting,
                        color: Colors.black,
                        size: 27,
                      )),
              ],
            ),
            drawer: Drawer(
              elevation: 0,
              width: 300,
              child: Padding(
                padding: const EdgeInsets.all(20).copyWith(top: 5, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DrawerHeader(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfileScreen(),
                                      ));
                                },
                                child: const CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      AssetImage('assets/images/profile.jpg'),
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  showCustomBottomSheet(context);
                                  // scaffoldKey.currentState!.showBottomSheet(
                                  //     (context) => Container(
                                  //         height:
                                  //             MediaQuery.sizeOf(context).height *
                                  //                 0.5,
                                  //         width: double.infinity,
                                  //         color: Colors.blue,
                                  //         child: Column()));
                                },
                                child: const Icon(
                                  IconBroken.More_Circle,
                                  size: 28,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfileScreen(),
                                      ));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${user?.name}",
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w900,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    Text(
                                      "${user?.email}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${user?.following} ",
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  Text(
                                    'Following',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${user?.followers} ",
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  Text(
                                    'Followers',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          listTileItem(
                            context,
                            icon: IconBroken.Profile,
                            text: 'Profile',
                            navigatTo: const ProfileScreen(),
                          ),
                          listTileItem(
                            context,
                            icon: Icons.verified_outlined,
                            text: 'Blue',
                            navigatTo: const BlueScreen(),
                          ),
                          listTileItem(
                            context,
                            icon: IconBroken.Bookmark,
                            text: 'BookMarks',
                            navigatTo: const BookMarksScreen(),
                          ),
                          listTileItem(
                            context,
                            icon: IconBroken.Category,
                            text: 'Lists',
                            navigatTo: const ListScreen(),
                          ),
                          listTileItem(
                            context,
                            icon: IconBroken.Voice_2,
                            text: 'Spaces',
                            navigatTo: const SpacesScreen(),
                          ),

                          const Divider(),
                          // ExpansionTile(
                          //   shape: BeveledRectangleBorder(side: BorderSide.none),
                          //   title: Text('Professional Tools'),
                          //   childrenPadding: EdgeInsets.only(right: 20),
                          //   children: [
                          //     ListTile(
                          //       leading: Icon(IconBroken.Shield_Done),
                          //       title: Text('For Professionals'),
                          //       onTap: () {},
                          //     ),
                          //     ListTile(
                          //       leading: Icon(IconBroken.Paper_Upload),
                          //       title: Text('Monetization'),
                          //       onTap: () {},
                          //     ),
                          //   ],
                          // ),
                          ExpansionTile(
                            shape: const BeveledRectangleBorder(
                                side: BorderSide.none),
                            title: const Text('Setting & Support'),
                            childrenPadding: const EdgeInsets.only(right: 20),
                            children: [
                              ListTile(
                                leading: const Icon(IconBroken.Setting),
                                title: const Text('Setting and Privacy'),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SettingScreen(),
                                      ));
                                },
                              ),
                              // ListTile(
                              //   leading: Icon(IconBroken.Info_Circle),
                              //   title: Text('Help Center'),
                              //   onTap: () {},
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // ListTile(
                    //   contentPadding: EdgeInsets.only(bottom: 20, right: 16),
                    //   leading: Icon(Icons.light_mode_outlined),
                    //   onTap: () {},
                    // )
                  ],
                ),
              ),
            ),
            body: cubit.screens[cubit.currentIndex],
            floatingActionButton: cubit.currentIndex == 0
                ? FloatingActionButton(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(50), // Define a custom shape
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TweetNewPost(),
                          ));
                    },
                    backgroundColor: Colors.blue,
                    child: const Icon(
                      Icons.add,
                      // size: 25,
                      color: Colors.white,
                    ),
                  )
                : null,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (value) {
                cubit.changeIndexBottomNavigationBar(value);
              },
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home),
                  label: '',
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(IconBroken.Search),
                //   label: '',
                // ),
                // BottomNavigationBarItem(
                //   icon: Icon(IconBroken.Notification),
                //   label: '',
                // ),
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Message),
                  label: '',
                ),
              ],
              showSelectedLabels: false,
              showUnselectedLabels: false,
            ),
          );
        },
      ),
    );
  }

  void showCustomBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Makes the bottom sheet full screen
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 7,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[500],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Account',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              AssetImage('assets/images/profile.jpg'),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  HomeCubit.userModel!.name!,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                const Icon(
                                  Icons.verified,
                                  color: Colors.blue,
                                  size: 15,
                                ),
                              ],
                            ),
                            Text(
                              HomeCubit.userModel!.email!,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            (route) => false);
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: Colors.grey.withOpacity(0.7)),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Text(
                          'Create a new account',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
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
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: Colors.grey.withOpacity(0.7)),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Text(
                          'Log out',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ListTile listTileItem(context,
      {required IconData icon,
      required String text,
      required Widget navigatTo}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.black,
      ),
      title: Text(
        text,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => navigatTo,
            ));
      },
    );
  }
}
