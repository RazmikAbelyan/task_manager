
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object> get props => [];

  const TaskState();
}

class TaskInitialState extends TaskState {
  final String taskDetail;

  TaskInitialState({@required this.taskDetail,});
  // @override
  // List<Object> get props => [taskDetail];
}

class TaskLoadedState extends TaskState {


}
class TaskLoadingState extends TaskState{}
