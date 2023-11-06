abstract class RegisterStates {}

class InitialRegisterState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class CreateUserSuccessState extends RegisterStates {}

class CreateUserErrorState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {}
