import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/constants.dart';
import 'package:social_app/core/models/user_model.dart';
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

  void updateUserProfile(
    context, {
    String? name,
    String? email,
    String? bio,
    String? date,
    // String? location,
    // required String website,
    String? cover,
    String? image,
  }) {
    UserModel model = UserModel(
      uId: HomeCubit.userModel!.uId,
      name: name ?? HomeCubit.userModel!.name,
      email: email ?? HomeCubit.userModel!.email,
      date: date ?? HomeCubit.userModel!.date,
      cover: cover ?? HomeCubit.userModel!.cover,
      image: image ?? HomeCubit.userModel!.image,
      bio: bio ?? HomeCubit.userModel!.bio,
    );
    // if (profileImage != null) {
    //   updateProfileImage();
    // }
    // if (coverImage != null) {
    //   updateCoverImage();
    // }

    FirebaseFirestore.instance
        .collection('users')
        .doc(HomeCubit.userModel?.uId)
        .update(model.toJson()!)
        .then((value) {
      HomeCubit.get(context).getUser();
    }).catchError((e) {
      print(e);
      emit(UpdateUserProfileErrorState());
    });
  }
}
