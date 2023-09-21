class Task {
  String? id;
  String? title;
  bool? completed;

  Task({
    required this.id,
    required this.title,
    this.completed = false,
  });

  static List<Task> taskList() {
    return [
      Task(id: '01', title: "Tarea 1", completed: true),
      Task(id: '02', title: "Tarea 2", completed: false),
      Task(id: '03', title: "Tarea 3"),
      Task(id: '04', title: "Tarea 4"),
      Task(id: '05', title: "Tarea 5", completed: true)
    ];
  }
}
