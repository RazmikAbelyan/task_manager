import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class FirebaseEvent extends Equatable {
  const FirebaseEvent();

  @override
  List<Object> get props => [];
}

class FirebaseStartedEvent extends FirebaseEvent {}

class FirebaseLoadingEvent extends FirebaseEvent {}

class FirebaseLoadedEvent extends FirebaseEvent {}

class FirebaseAddNewUserEvent extends FirebaseEvent {
  final String  username;
  FirebaseAddNewUserEvent({this.username});
}

class FirebaseFailedEvent extends FirebaseEvent {}

class OpenUserTaskEvent extends FirebaseEvent {
  final BuildContext ctx;

  OpenUserTaskEvent({@required this.ctx});
}
