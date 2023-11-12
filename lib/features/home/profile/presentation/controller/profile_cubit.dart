import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/constants.dart';
import 'package:social_app/features/home/home_page/presentation/controller/home_cubit/home_cubit.dart';
import 'package:social_app/features/home/profile/presentation/controller/profile_states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());
  static ProfileCubit get(context) => BlocProvider.of(context);

  File? profileImage;
  File? coverImage;
  chooseProfileImage() async {
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ChooseImageSuccessState());
    } else {
      print('No Image Selected');
      emit(ChooseImageErrorState());
    }
  }

  chooseCoverImage() async {
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);

      emit(ChooseImageSuccessState());
    } else {
      print('No Image Selected');
      emit(ChooseImageErrorState());
    }
  }

  updateProfileAndCoverImages() {
    updateProfileImage();
    updateCoverImage();
  }

  updateProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(uId)
            .update({'image': value});
        HomeCubit.userModel!.image = value;
        emit(UpdateImageSuccessState());
      }).catchError((e) {
        print(e);
        emit(UpdateImageErrorState());
      });
    });
  }

  updateCoverImage() {
    firebase_storage.FirebaseStorage.instance
        .ref('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(uId)
            .update({'cover': value});
        HomeCubit.userModel!.cover = value;
        emit(UpdateImageSuccessState());
      }).catchError((e) {
        print(e);
        emit(UpdateImageErrorState());
      });
    });
  }
}
