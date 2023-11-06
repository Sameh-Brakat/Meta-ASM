import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/utils/bloc_observe.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_app/core/utils/cashe_helper.dart';
import 'package:social_app/features/authentication/login/presentation/view/login_screen.dart';
import 'package:social_app/features/authentication/register/presentation/view/create_account.dart';
import 'package:social_app/features/home/home_page/presentation/view/home_screen.dart';
import 'package:social_app/firebase_options.dart';

import 'core/constants.dart';

void main() async {
  Widget widget;
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();

  uId = CacheHelper.getData(key: 'uId');

  print(uId);

  if (uId != null) {
    widget = HomeScreen();
  } else {
    widget = const LoginScreen();
  }
  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.startWidget});
  final Widget startWidget;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: startWidget,
    );
  }
}
