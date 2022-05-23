import 'package:flutter/material.dart';
import 'task.dart';
import 'main.dart';
import 'taskdetails.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  final int index;
  const TaskItem(this.task, this.index, {Key? key}) : super(key: key);

  @override
  State<TaskItem> createState() => TaskItemState();
}

class TaskItemState extends State<TaskItem> {
  colorPicker(task) {
    if (task.done) {
      return const Color(0x9E86FC33);
    } else if (task.deadline.isAfter(DateTime.now())) {
      return const Color(0xEB171813);
    } else {
      return const Color(0x85FF0303);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Theme(
                data: ThemeData(
                  splashColor: Colors.red,
                  highlightColor: Colors.black.withOpacity(.10),
                ),
                child: ListTile(
                  tileColor: colorPicker(widget.task),
                  leading: IconButton(
                    icon: const Icon(Icons.delete_rounded),
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        removeTask(widget.index);
                      });
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                  ),
                  title: Text(
                    widget.task.title,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  subtitle: Text(
                    widget.task.description,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskDetails(widget.task),
                      ),
                    );
                  },
                  trailing: GestureDetector(
                    onTap: () {
                      setState(() {
                        changeDone(widget.index);
                      });
                    },
                    child: widget.task.done
                        ? const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 30,
                          )
                        : Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.white,
                                border: Border.all(width: 1)),
                            child: const Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const Divider(height: 3),
      ],
    );
  }
}
