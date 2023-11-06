import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/home/home_page/presentation/controller/home_cubit/home_cubit.dart';
import 'package:social_app/features/home/posts/presentation/controller/tweets_screen_states.dart';

class TweetsScreenCubit extends Cubit<TweetsScreenStates> {
  TweetsScreenCubit() : super(TweetsScreenInitialState());

  static TweetsScreenCubit get(context) => BlocProvider.of(context);

  likeTweet({required String tweetId, required bool like}) {
    FirebaseFirestore.instance
        .collection('tweets')
        .doc(tweetId)
        .collection('likes')
        .doc(HomeCubit.userModel!.uId)
        .set({'like': like}).then((value) {
      emit(TweetLikeSuccessState());
    }).catchError((e) {
      print(e);
      emit(TweetLikeErrorState());
    });
  }
}
