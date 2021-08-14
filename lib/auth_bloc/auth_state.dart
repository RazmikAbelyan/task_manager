import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitialState extends AuthState {
  final bool isLogin;
  String errorMessage;
  AuthInitialState({this.isLogin, this.errorMessage});
  @override
  List<Object> get props => [isLogin, errorMessage];
}


class AuthLogInFiledState extends AuthState {
  final String errorMessage;
  AuthLogInFiledState({this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
class AuthSignUpFiledState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthSuccessState extends AuthState {
  @override
  List<Object> get props => [];
}
class AuthLoadingState extends AuthState {
  @override
  List<Object> get props => [];
}
