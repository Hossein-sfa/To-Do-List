import 'package:flutter/material.dart';
import 'task.dart';
import 'main.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => AddTaskState();
}

class AddTaskState extends State<AddTask> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (context, childWidget) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: childWidget!,
        );
      },
    );
    if (picked != null && picked != selectedTime) {
      setState(() => selectedTime = picked);
    }
  }

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          },
        ),
        backgroundColor: const Color(0xFF404040),
        title: const Text(
          "Adding Task",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Center(
        child: Column(children: [
          const SizedBox(height: 15),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextField(
                    controller: title,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      fillColor: const Color(0x00000045),
                      labelText: 'Title:',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              maxLines: 12,
              controller: description,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                fillColor: const Color(0x00000045),
                labelText: 'Description:',
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0x72860DDD), width: 4),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          TextButton(
            onPressed: () => selectDate(context),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today_rounded,
                  size: 30,
                  color: Color(0xA8850087),
                ),
                const SizedBox(width: 10),
                Text(
                  "${selectedDate.toLocal()}".split(' ')[0],
                  style: const TextStyle(fontSize: 25, color: Colors.black),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
          const SizedBox(height: 30),
          TextButton(
            onPressed: () => selectTime(context),
            child: Row(
              children: [
                const Icon(
                  Icons.alarm,
                  size: 30,
                  color: Color(0xA8850087),
                ),
                const SizedBox(width: 10),
                Text(
                  selectedTime.format(context),
                  style: const TextStyle(fontSize: 25, color: Colors.black),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              DateTime tempDeadline = DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  selectedDate.day,
                  selectedTime.hour,
                  selectedTime.minute);
              Task tempTask =
                  Task(title.text, description.text, tempDeadline, false);
              if (tempTask.title != '' && tempTask.description != '') {
                addTask(tempTask);
              }
              title.clear();
              description.clear();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
            child: const Text('Add'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              primary: Colors.purple,
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
            ),
          ),
        ]),
      ),
    );
  }
}
