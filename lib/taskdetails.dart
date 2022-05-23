import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'main.dart';
import 'task.dart';

class TaskDetails extends StatefulWidget {
  final Task task;
  const TaskDetails(this.task, {Key? key}) : super(key: key);

  @override
  State<TaskDetails> createState() => TaskDetailsState();
}

class TaskDetailsState extends State<TaskDetails> {
  final DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");

  @override
  Widget build(BuildContext context) {
    bool isSwitched = widget.task.done;
    return Scaffold(
      body: Container(
        color: const Color(0xFF1E1E21),
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                title: const Text("Task Details"),
                backgroundColor: const Color(0xFF404040),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const HomeScreen(), // adding parameter to constructor
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const SizedBox(width: 15),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 40,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    child: Text(
                      ' ' + widget.task.title,
                      style: const TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontSize: 28),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width - 30,
                height: 350,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Text(
                  widget.task.description,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width - 30,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                height: 40,
                child: Text(
                  ' ' + dateFormat.format(widget.task.deadline),
                  style: const TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      fontSize: 28),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Done: ',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          widget.task.done = value;
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: const Color(0xC3E600FF),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
