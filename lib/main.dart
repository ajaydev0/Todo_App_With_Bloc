import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/todo_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: BlocProvider(
          create: (context) => TodoCubit(),
          child: const MyHomePage(title: 'Todo App')),
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
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  BlocProvider.of<TodoCubit>(context).addTodo(controller.text);
                },
                child: const Text(" Add ")),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  BlocProvider.of<TodoCubit>(context).closeAll();
                },
                child: const Text("Clear All")),
            const SizedBox(height: 10),
          
               Expanded(
                    child: BlocBuilder<TodoCubit, TodoInitial>(
                      builder: (context, state) {
                        return ListView.builder(
                          itemCount: state.todos.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 3,
                              child: ListTile(
                                  title: Text(state.todos[index]),
                                  trailing: IconButton(
                                      onPressed: () {
                                        BlocProvider.of<TodoCubit>(context)
                                            .deleteTodo(index);
                                      },
                                      icon: const Icon(Icons.delete))),
                            );
                          },
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
