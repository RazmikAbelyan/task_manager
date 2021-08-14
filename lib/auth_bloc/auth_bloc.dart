import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _auth = FirebaseAuth.instance;
  UserCredential authResult;
  bool isLogin = true;
  String err = '';

  AuthBloc() : super(AuthInitialState(isLogin: true, errorMessage: '',));

  @override
  AuthState get initialState => AuthInitialState(isLogin: isLogin, errorMessage: err);

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthSignUpEvent) {
      yield* _mapSignUpEventToState(event);
    } else if (event is AuthLoginEvent) {
      yield* _mapLoginEventToState(event);
    } else if (event is AuthSwitchToSignUpEvent) {
      yield* _mapSwitchToSignUpEventToState(event);
    }else if (event is AuthInitialEvent){
      yield* _mapInitEventToState(event);
    }
  }

  Stream<AuthState> _mapSignUpEventToState(AuthSignUpEvent event) async* {
    authResult = await _auth.createUserWithEmailAndPassword(
      email: event.email,
      password: event.password,
    );
    try {
      yield AuthLoadingState();
      await FirebaseFirestore.instance.collection('users').doc(authResult.user.uid).set({
        'username': event.username,
        'email': event.email,
      });
      yield AuthSuccessState();
    } catch (error) {
      yield AuthSignUpFiledState();
    }
  }

  Stream<AuthState> _mapLoginEventToState(AuthLoginEvent event) async* {

    yield AuthLoadingState();
    try {

      authResult = await _auth.signInWithEmailAndPassword(
        email: event.logEmail,
        password: event.logPassword,
      );
    } catch (err) {

      yield AuthInitialState(errorMessage: err.code, isLogin: isLogin);

    }
      yield AuthSuccessState();

  }

  Stream<AuthState> _mapSwitchToSignUpEventToState(AuthSwitchToSignUpEvent event) async* {
    isLogin = !isLogin;
    yield AuthInitialState(isLogin: isLogin, errorMessage: '');
  }



  Stream<AuthState> _mapInitEventToState(AuthInitialEvent event)async* {
    yield AuthInitialState(errorMessage: '', isLogin: isLogin);
  }

}
