abstract class AuthState {
}

class InitState extends AuthState{}
class LoginState extends AuthState{}

class LoginSuccess extends LoginState{
  String msg;
  LoginSuccess({required this.msg});
}
class LoginFailed extends LoginState{

  String msg;
  LoginFailed({required this.msg});
}