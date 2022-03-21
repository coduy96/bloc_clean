import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/blocs/todos/todo_bloc.dart';
import 'package:todo/blocs/todos_filter/todos_filter_bloc.dart';
import 'package:todo/screens/home_screen.dart';

import 'models/todos_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoBloc()
            ..add(
              LoadTodos(todos: [
                Todo(
                    id: '1',
                    task: 'Sample 1',
                    description: 'This is descriptions 1'),
                Todo(
                    id: '2',
                    task: 'Sample 2',
                    description: 'This is descriptions 2'),
              ]),
            ),
        ),
        BlocProvider(
            create: (context) =>
                TodosFilterBloc(todoBloc: BlocProvider.of(context))),
      ],
      child: const MaterialApp(
        title: 'BLoc',
        home: HomeScreen(),
      ),
    );
  }
}
