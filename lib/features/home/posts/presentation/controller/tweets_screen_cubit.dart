import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/constants.dart';
import 'package:social_app/core/models/react_tweet_model.dart';
import 'package:social_app/features/home/home_page/presentation/controller/home_cubit/home_cubit.dart';
import 'package:social_app/features/home/posts/presentation/controller/tweets_screen_states.dart';

class TweetsScreenCubit extends Cubit<TweetsScreenStates> {
  TweetsScreenCubit() : super(TweetsScreenInitialState());

  static TweetsScreenCubit get(context) => BlocProvider.of(context);

  getReactTweet({
    required String tweetId,
    required String userId,
  }) async {
    await FirebaseFirestore.instance
        .collection('tweets')
        .doc(tweetId)
        .collection('reacts')
        .doc(userId)
        .get()
        .then((value) {
      LikeTweetModel reactTweetModel = LikeTweetModel.fromJson(value.data());
      return reactTweetModel;
      // print(value.data()!['like']);
    });
  }

  likeTweet({required String tweetId, required bool like}) {
    FirebaseFirestore.instance
        .collection('tweets')
        .doc(tweetId)
        .collection('reacts')
        .doc(HomeCubit.userModel!.uId)
        .set({'like': like}).then((value) {
      emit(TweetLikeSuccessState());
    }).catchError((e) {
      print(e);
      emit(TweetLikeErrorState());
    });
  }
}
