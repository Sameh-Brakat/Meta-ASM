import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/components/search.dart';
import 'package:social_app/core/constants.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/features/home/home_page/presentation/controller/home_cubit/home_states.dart';
import 'package:social_app/features/home/mails/presentation/view/mails_screen.dart';
import 'package:social_app/features/home/notification/presentation/view/notification_screen.dart';
import 'package:social_app/features/home/posts/presentation/view/tweets_screen.dart';
import 'package:social_app/features/home/search/presentation/view/search_screen.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  static UserModel? userModel;
  getUser() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((e) {
      print('Error is : $e');
      emit(GetUserErrorState());
    });
  }

  int currentIndex = 0;

  changeIndexBottomNavigationBar(value) {
    currentIndex = value;
    emit(ChangeBottomNavigationBarState());
  }

  List<Widget> screens = [
    const TweetsScreen(),
    const SearchScreen(),
    const NotificationScreen(),
    const MailsScreen(),
  ];
  List<Widget> title = [
    const CircleAvatar(
      radius: 20,
      backgroundImage: AssetImage('assets/images/logo.png'),
    ),
    Container(
      padding: const EdgeInsets.all(10),
      width: 250,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        'Search ASM',
        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
      ),
    ),
    const Text(
      'Notifications',
      style: TextStyle(fontWeight: FontWeight.w500),
    ),
    Container(
      padding: const EdgeInsets.all(10),
      width: 250,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        'Search Direct Messages',
        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
      ),
    ),
  ];

  void navigatorToNewScreen(context) {
    if (currentIndex == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Search(
              title: 'Search ASM',
            ),
          ));
    } else if (currentIndex == 3) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Search(
              title: 'Search Direct Messages',
            ),
          ));
    }
  }
}
