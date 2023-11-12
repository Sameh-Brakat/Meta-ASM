import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/components/toast.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/cashe_helper.dart';
import 'package:social_app/features/authentication/login/presentation/controller/login_screen_states.dart';
import 'package:social_app/features/home/home_page/presentation/controller/home_cubit/home_cubit.dart';
import 'package:social_app/features/home/home_page/presentation/view/home_screen.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialLoginState());

  static LoginCubit get(context) => BlocProvider.of(context);

  Future<UserCredential?> userLogin(
    context, {
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        CacheHelper.saveData(key: 'uId', value: value.user!.uid).then((value) {
          Toastt(message: "Sign in Successfully", state: ToastStates.SUCCESS);
          emit(LoginSuccessState());
        }).catchError((e) {
          print('Error is : $e');
          emit(LoginErrorState());
        });
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
      print('Failed with error code: ${e.code}');
      print(e.email);
      emit(LoginErrorState());
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      emit(LoginErrorState());
    }
  }
}
