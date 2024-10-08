import 'dart:convert';

class TaskModel {
  final String taskName;
  final bool isTaskCompleted;
  TaskModel({
    required this.taskName,
    required this.isTaskCompleted,
  });

  TaskModel copyWith({
    String? taskName,
    bool? isTaskCompleted,
  }) {
    return TaskModel(
      taskName: taskName ?? this.taskName,
      isTaskCompleted: isTaskCompleted ?? this.isTaskCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'taskName': taskName,
      'isTaskCompleted': isTaskCompleted,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      taskName: map['taskName'] ?? '',
      isTaskCompleted: map['isTaskCompleted'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'TaskModel(taskName: $taskName, isTaskCompleted: $isTaskCompleted)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskModel &&
        other.taskName == taskName &&
        other.isTaskCompleted == isTaskCompleted;
  }

  @override
  int get hashCode => taskName.hashCode ^ isTaskCompleted.hashCode;
}
