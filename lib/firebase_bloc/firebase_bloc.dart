import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_event.dart';
import 'firebase_state.dart';

class FirebaseBloc extends Bloc<FirebaseEvent, FirebaseState> {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  FirebaseBloc() : super(FirebaseStartedState());

  @override
  FirebaseState get initialState => FirebaseStartedState();

  @override
  Stream<FirebaseState> mapEventToState(FirebaseEvent event) async* {
    if (event is FirebaseStartedEvent) {

      yield* _mapStartedToState(event);

    } else if (event is FirebaseLoadingEvent) {

      yield* _mapLoadingToState(event);

    } else if (event is FirebaseLoadedEvent) {

      yield* _mapLoadedToState(event);

    }else if (event is FirebaseAddNewUserEvent){

      yield* _mapAddNewUser(event);
    }
  }

  Stream<FirebaseState> _mapStartedToState(FirebaseStartedEvent event) async* {
    yield FirebaseStartedState();
  }

  Stream<FirebaseState> _mapLoadingToState(FirebaseLoadingEvent event) async* {
    yield FirebaseLoadingState();
  }

  Stream<FirebaseState> _mapLoadedToState(FirebaseLoadedEvent event) async* {
    yield FirebaseLoadingState();
    try {
      final collection = await _firebase.collection('users').get();
      final docs = collection.docs;
      print(docs.length);

      yield FirebaseLoadedState(docs: docs);
    } catch (err) {
      yield FirebaseFailedState();
    }
  }

 Stream<FirebaseState> _mapAddNewUser(FirebaseAddNewUserEvent event) async*{
    yield FirebaseLoadingState();
    await FirebaseFirestore.instance.collection('users').add({'username' : event.username});
    final collection = await _firebase.collection('users').get();
    final docs = collection.docs;
    yield FirebaseLoadedState(docs: docs);
 }


}
