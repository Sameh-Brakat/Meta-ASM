import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/home/mails/presentation/controller/mails_screen_states.dart';

class MailsScreenCubit extends Cubit<MailsScreenStates> {
  MailsScreenCubit() : super(MailsScreenInitialState());

  static MailsScreenCubit get(context) => BlocProvider.of(context);

  // likeTweet({required String tweetId, required bool like}) {
  //   FirebaseFirestore.instance
  //       .collection('tweets')
  //       .doc(tweetId)
  //       .collection('likes')
  //       .doc(HomeCubit.userModel!.uId)
  //       .set({'like': like}).then((value) {
  //     emit(TweetLikeSuccessState());
  //   }).catchError((e) {
  //     print(e);
  //     emit(TweetLikeErrorState());
  //   });
  // }
}
