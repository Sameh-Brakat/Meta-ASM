import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/models/tweet_model.dart';
import 'package:social_app/features/home/home_page/presentation/controller/home_cubit/home_cubit.dart';
import 'package:social_app/features/home/home_page/presentation/controller/tweets_cubit/tweets_states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class TweetsCubit extends Cubit<TweetsStates> {
  TweetsCubit() : super(TweetsInitialState());

  static TweetsCubit get(context) => BlocProvider.of(context);

  File? tweetImage;

  createTweet({
    required String tweetText,
    required String tweetDate,
    required String tweetTime,
    String? tweetImage,
  }) {
    emit(CreateTweetLoadingState());

    TweetModel tweetModel = TweetModel(
      userId: HomeCubit.userModel?.uId,
      name: HomeCubit.userModel?.name,
      email: HomeCubit.userModel?.email,
      tweetText: tweetText,
      tweetDate: tweetDate,
      tweetTime: tweetTime,
      tweetImage: tweetImage,
      profileImage: HomeCubit.userModel?.image,
    );

    FirebaseFirestore.instance
        .collection('tweets')
        .add(tweetModel.toMap()!)
        .then((value) {
      // print(value.id);
      tweetModel.tweetId = value.id;
      value.update({'tweetId': value.id}).then(
        (value) {
          emit(CreateTweetSuccessState());
        },
      ).catchError((e) {
        print('Error in handle tweet id');
        emit(CreateTweetErrorState());
      });
    }).catchError((e) {
      print('Error is : $e');
      emit(CreateTweetErrorState());
    });
  }

  createTweetWithImage({
    required String tweetText,
    required String tweetDate,
    required String tweetTime,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('tweets/${Uri.file(tweetImage!.path).pathSegments.last}')
        .putFile(tweetImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print('This is photo $value');
        createTweet(
            tweetText: tweetText,
            tweetDate: tweetDate,
            tweetImage: value,
            tweetTime: tweetTime);
        emit(UploadImageSuccessState());
      }).catchError((e) {
        print(e);
        emit(UploadImageErrorState());
      });
    }).catchError((e) {
      print(e);
      emit(UploadImageErrorState());
    });
  }

  addTweetImage() async {
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      tweetImage = File(pickedFile.path);
      emit(AddTweetImageSuccessState());
    } else {
      print('No Image Selected');
      emit(AddTweetImageErrorState());
    }
  }
}
