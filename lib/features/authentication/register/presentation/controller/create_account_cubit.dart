import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/components/toast.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/cashe_helper.dart';
import 'package:social_app/features/authentication/register/presentation/controller/create_account_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitialRegisterState());

  static RegisterCubit get(context) => BlocProvider.of(context);
///////////////////
  Future<UserCredential?> userRegister(
    context, {
    required String name,
    required String email,
    required String password,
    required String date,
  }) async {
    emit(RegisterLoadingState());
    try {
      return await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        createUserAccount(
            uId: value.user!.uid, name: name, email: email, date: date);

        CacheHelper.saveData(key: 'uId', value: value.user!.uid)
            .then((value) {});
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The password provided is too weak.')));
        Toastt(
            message: 'The password provided is too weak.',
            state: ToastStates.ERROR);
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The account already exists for that email.')));
        // Toastt(
        //     message: 'The account already exists for that email.',
        //     state: ToastStates.ERROR);
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      // Toastt(message: e.toString(), state: ToastStates.ERROR);
    }
  }

  createUserAccount({
    required String uId,
    required String name,
    required String email,
    required String date,
  }) async {
    UserModel userModel = UserModel(
      uId: uId,
      name: name,
      email: email,
      date: date,
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toJson()!)
        .then((value) {
      Toastt(
          message: "The account has been created", state: ToastStates.SUCCESS);
      emit(CreateUserSuccessState());
    }).catchError((e) {
      print(e);
      emit(CreateUserErrorState());
    });
  }
}
