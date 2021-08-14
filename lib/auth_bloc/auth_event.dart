import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthSignUpEvent extends AuthEvent {
  final String email;
  final String username;
  final String password;

  AuthSignUpEvent({this.username, this.email, this.password});

  @override
  List<Object> get props => [username, email, password];
}

class AuthLoginEvent extends AuthEvent {
  final String logEmail;
  final String logUsername;
  final String logPassword;

AuthLoginEvent({this.logEmail, this.logUsername, this.logPassword});
   @override
  List<Object> get props => [logEmail, logPassword];
}

class AuthInitialEvent extends AuthEvent {

  @override
  List<Object> get props => [];
}

class AuthLoadingEvent extends AuthEvent {

  @override
  List<Object> get props => [];
}
class AuthSwitchToSignUpEvent extends AuthEvent {

  @override
  List<Object> get props => [];
}
class AuthSwitchToLogInEvent extends AuthEvent {

  @override
  List<Object> get props => [];
}
