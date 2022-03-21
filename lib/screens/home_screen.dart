import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/blocs/todos/todo_bloc.dart';
import 'package:todo/blocs/todos_filter/todos_filter_bloc.dart';
import 'package:todo/models/todos_filter_model.dart';
import 'package:todo/screens/add_todo_screen.dart';

import '../models/todos_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo App'),
          leading: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const AddTodoScreen()));
            },
          ),
          bottom: TabBar(
            onTap: (tabIndex) {
              switch (tabIndex) {
                case 0:
                  BlocProvider.of<TodosFilterBloc>(context)
                      .add(const UpdateTodos(todosFilter: TodosFilter.pending));

                  break;
                case 1:
                  BlocProvider.of<TodosFilterBloc>(context).add(
                      const UpdateTodos(todosFilter: TodosFilter.completed));

                  break;
              }
            },
            tabs: const [
              Tab(
                icon: Icon(Icons.pending),
              ),
              Tab(
                icon: Icon(Icons.add_task),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          _todos("Pending"),
          _todos("Complete"),
        ]),
      ),
    );
  }

  BlocBuilder<TodosFilterBloc, TodosFilterState> _todos(String title) {
    return BlocBuilder<TodosFilterBloc, TodosFilterState>(
      builder: (context, state) {
        if (state is TodosFilterLoading) {
          return const CircularProgressIndicator();
        }
        if (state is TodosFilterLoaded) {
          return Column(
            children: [
              SizedBox(height: 50, child: Text(title)),
              Expanded(
                child: ListView.builder(
                    itemCount: state.filteredTodos.length,
                    itemBuilder: ((context, index) =>
                        _todoCard(context, state.filteredTodos[index]))),
              ),
            ],
          );
        } else {
          return const Text('Error');
        }
      },
    );
  }

  Widget _todoCard(BuildContext context, Todo todo) {
    return ListTile(
      title: Expanded(flex: 2, child: Text(todo.task)),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                context
                    .read<TodoBloc>()
                    .add(UpdateTodo(todo: todo.copyWith(isCompleted: true)));
              },
              icon: const Icon(Icons.done),
            ),
            IconButton(
              onPressed: () {
                context.read<TodoBloc>().add(DeleteTodo(todo: todo));
              },
              icon: const Icon(
                Icons.cancel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
