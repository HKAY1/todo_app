import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/task_bloc.dart';
import 'package:todo_app/bloc/task_event.dart';
import 'package:todo_app/bloc/task_state.dart';

import 'models/task_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(),
      child: MaterialApp(
        title: 'Todo Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Todo App'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TaskBloc bloc;
  @override
  void initState() {
    bloc = context.read<TaskBloc>();
    super.initState();
  }

  void _addTask() {
    bloc.controller.clear();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Material(
                child: AddTask(
              bloc: bloc,
            )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskInitial) {
            return const Center(
              child: Text("No Tasks"),
            );
          }
          if (state is TaskListState) {
            if (state.data.isEmpty) {
              return const Center(
                child: Text("No Tasks"),
              );
            }
            return ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, i) {
                  return TaskList(data: state.data[i], index: i, bloc: bloc);
                });
          }
          if (state is TaskLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TaskList extends StatefulWidget {
  final TaskModel data;
  final int index;
  final TaskBloc bloc;
  const TaskList(
      {super.key, required this.data, required this.index, required this.bloc});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: widget.data.isTaskCompleted,
      onChanged: (isChanged) {
        widget.bloc.add(UpdateTask(widget.index, !widget.data.isTaskCompleted));
        setState(() {});
      },
      title: Text(
        widget.data.taskName,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}

class AddTask extends StatelessWidget {
  final TaskBloc bloc;
  const AddTask({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextField(
            controller: bloc.controller,
            decoration: const InputDecoration(
              labelText: "Task Name",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                bloc.add(AddTaskEvent());
                Navigator.pop(context);
              },
              child: const Text("Add"))
        ],
      ),
    );
  }
}
