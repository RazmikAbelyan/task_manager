import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../task_bloc/task_bloc.dart';
import '../task_bloc/task_state.dart';
import '../task_bloc/task_event.dart';

class TaskDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String argsId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Task'),
        centerTitle: true,
      ),
      body: BlocProvider<TaskBloc>(
        create: (ctx) => TaskBloc()..add(TaskStartedEvent(id: argsId)),
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (ctx, state) {
            if (state is TaskLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }else if (state is TaskInitialState){
            return Center(
              child: Text((state.taskDetail == null ? 'NO task' : state.taskDetail)

              ),
            );
            }
            return Container();


          },
        ),
      ),
    );
  }
}
