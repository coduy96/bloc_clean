import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/blocs/todos/todo_bloc.dart';
import 'package:todo/models/todos_model.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerId = TextEditingController();
    TextEditingController controllerTask = TextEditingController();
    TextEditingController controllerDescription = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Add to do')),
      body: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoLoaded) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('To do added')));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: controllerId,
                decoration: const InputDecoration(label: Text('Id')),
              ),
              TextField(
                controller: controllerTask,
                decoration: const InputDecoration(label: Text('Task')),
              ),
              TextField(
                controller: controllerDescription,
                decoration: const InputDecoration(label: Text('Description')),
              ),
              ElevatedButton(
                  onPressed: () {
                    Todo todo = Todo(
                        id: controllerId.text,
                        task: controllerTask.text,
                        description: controllerDescription.text);
                    context.read<TodoBloc>().add(AddTodos(todo: todo));
                    Navigator.pop(context);
                  },
                  child: const Text('Add to do')),
            ],
          ),
        ),
      ),
    );
  }
}
