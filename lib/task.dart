class Task {
  String title, description;
  DateTime deadline;
  bool done = false;

  Task(this.title, this.description, this.deadline, this.done);

  isDone() => done = true;
}
