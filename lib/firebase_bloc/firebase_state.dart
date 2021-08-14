import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class FirebaseState extends Equatable {
  @override
  List<Object> get props => [];

  const FirebaseState();
}

class FirebaseStartedState extends FirebaseState {}

class FirebaseLoadingState extends FirebaseState{}

class FirebaseLoadedState extends FirebaseState {
  final List<QueryDocumentSnapshot> docs;


  FirebaseLoadedState({this.docs,});
}
class FirebaseFailedState extends FirebaseState{}