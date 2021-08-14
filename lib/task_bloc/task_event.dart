import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];


}
class TaskLoadingEvent extends TaskEvent{}

class TaskLoadedEvent extends TaskEvent{}

class TaskStartedEvent extends TaskEvent{

  final String id;
  TaskStartedEvent({@required this.id});
  @override
  List<Object> get props => [id];
}

