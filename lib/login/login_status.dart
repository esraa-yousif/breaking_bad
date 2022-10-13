abstract class LoginState {}

class LoginInitState extends LoginState{}
class LoginLoadingState extends LoginState{}
class LoginSuccessState extends LoginState{}
class LoginErrorState extends LoginState{
  final String message;

  LoginErrorState({required this.message});
}