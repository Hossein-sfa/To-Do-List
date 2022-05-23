// Hossein Safaei
// 400243050

import 'package:flutter/material.dart';
import 'taskitem.dart';
import 'task.dart';
import 'addtask.dart';

void main() => runApp(const ToDoList());

class ToDoList extends StatelessWidget {
  const ToDoList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

List<Task> tasks = [];

addTask(task) {
  tasks.add(task);
  tasks = taskSorter(tasks);
}

changeDone(int index) {
  tasks[index].done = !tasks[index].done;
}
removeTask(index) {
  tasks.removeAt(index);
}

taskSorter(List<Task> list) {
  for (int i = 0; i < list.length - 1; i++) {
    for (int j = 0; j < list.length - i - 1; j++) {
      if (list[j].deadline.isAfter(list[j + 1].deadline)) {
        Task temp = list[j];
        list[j] = list[j + 1];
        list[j + 1] = temp;
      }
    }
  }
  return list;
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF404040),
        title: const Text("To Do List", style: TextStyle(fontSize: 21)),
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.red,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTask(),
            ),
          );
        },
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFFB208C2), // background
        child: const Icon(
          Icons.add,
          size: 55,
          color: Color(0xD8000000),
        ),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskItem(tasks[index], index);
        },
      ),
    );
  }
}
