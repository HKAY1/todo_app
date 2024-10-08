import 'package:equatable/equatable.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

final class AddTaskEvent extends TaskEvent {}

final class InitailTask extends TaskEvent {}

final class UpdateTask extends TaskEvent {
  final int index;
  final bool chamge;

  const UpdateTask(this.index, this.chamge);

  @override
  List<Object?> get props => [index];
}
