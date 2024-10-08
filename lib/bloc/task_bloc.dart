import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/task_event.dart';
import 'package:todo_app/bloc/task_state.dart';
import 'package:todo_app/models/task_model.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on(_handler);
  }

  void _handler(TaskEvent event, Emitter<TaskState> emit) {
    if (event is InitailTask) {
      _init(emit);
    } else if (event is AddTaskEvent) {
      _addTask(emit);
    } else if (event is UpdateTask) {
      _updateTask(event.index, event.chamge, emit);
    }
  }

  final TextEditingController controller = TextEditingController();
  final List<TaskModel> model = [];

  void _init(Emitter<TaskState> emit) {
    emit(const TaskListState([]));
  }

  void _addTask(Emitter<TaskState> emit) {
    emit(TaskLoading());
    model.add(TaskModel(taskName: controller.text, isTaskCompleted: false));
    emit(TaskListState(model));
  }

  void _updateTask(int index, bool change, Emitter<TaskState> emit) {
    emit(TaskLoading());
    final elem = model[index].copyWith(isTaskCompleted: change);
    model.replaceRange(index, index, [elem]);
    model.removeAt(index + 1);
    emit(TaskListState(model));
  }
}
