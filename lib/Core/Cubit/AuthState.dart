abstract class AuthState {
}

class InitState extends AuthState{}

class LoginLoadingState extends AuthState{}
class LoginSuccess extends AuthState{
  String msg;
  LoginSuccess({required this.msg});
}
class LoginFailed extends AuthState{
  String msg;
  LoginFailed({required this.msg});
}


class OtpLoadingState extends AuthState{}
class OtpSuccess extends AuthState{
  String msg;
  OtpSuccess({required this.msg});
}
class OtpFailed extends AuthState{
  String msg;
  OtpFailed({required this.msg});
}


class RegisterLoadingState extends AuthState{}
class RegisterSuccess extends AuthState{
  String msg;
  RegisterSuccess({required this.msg});
}
class RegisterFailed extends AuthState{
  String msg;
  RegisterFailed({required this.msg});
}


class ProfileState extends AuthState{}
class LoadingProfileState extends ProfileState{}
class SuccessProfileProfileState extends ProfileState{}
class FailureProfileProfileState extends ProfileState{
}
