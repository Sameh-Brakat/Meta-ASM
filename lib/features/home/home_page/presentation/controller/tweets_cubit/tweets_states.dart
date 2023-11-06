abstract class TweetsStates {}

class TweetsInitialState extends TweetsStates {}

// create tweet
class CreateTweetLoadingState extends TweetsStates {}

class CreateTweetSuccessState extends TweetsStates {}

class AddTweetImageSuccessState extends TweetsStates {}

class AddTweetImageErrorState extends TweetsStates {}

class UploadImageSuccessState extends TweetsStates {}

class UploadImageErrorState extends TweetsStates {}

class CreateTweetErrorState extends TweetsStates {}
