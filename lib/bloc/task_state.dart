import 'package:equatable/equatable.dart';
import 'package:todo_app/models/task_model.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

final class TaskInitial extends TaskState {}

final class TaskLoading extends TaskState {}

final class TaskListState extends TaskState {
  final List<TaskModel> data;
  const TaskListState(this.data);

  @override
  List<List<TaskModel>?> get props => <List<TaskModel>>[data];
}
