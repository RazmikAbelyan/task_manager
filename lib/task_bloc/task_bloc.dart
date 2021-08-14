import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'task_state.dart';
import 'task_event.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  TaskBloc() : super(TaskInitialState());

  @override
  TaskState get initialState => TaskInitialState();

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is TaskStartedEvent) {
      yield* _mapTaskStartedToState(event);
    } else if (event is TaskLoadingEvent) {
      yield* _mapTaskLoadingToState(event);
    }
  }

  Stream<TaskState> _mapTaskStartedToState(TaskStartedEvent event) async* {
    try {
      yield TaskLoadingState();
      final task =
          await _firebase.collection('users').doc(event.id).get();
      final taskData = task.data()['tasks'];

      yield TaskInitialState(taskDetail: taskData);
    } catch (err) {
      print(err);
    }
  }

  Stream<TaskState> _mapTaskLoadingToState(TaskLoadingEvent event) async* {
    yield TaskLoadingState();
  }
}
