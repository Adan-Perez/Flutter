import 'package:flutter/material.dart';
import '../model/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final onTaskToggle;
  final onTaskDelete;

  const TaskItem(
      {Key? key, required this.task, this.onTaskToggle, this.onTaskDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ListTile(
          onTap: () {
            onTaskToggle(task);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tileColor: Colors.grey[200],
          leading: Icon(
              task.completed == true
                  ? Icons.check_circle
                  : Icons.check_circle_outline,
              color: Colors.green),
          title: Text(
            task.title ?? "Sin título",
            style: TextStyle(
                color: Colors.black,
                decoration: task.completed == true
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                fontSize: 16),
          ),
          trailing: IconButton(
            tooltip: 'Eliminar tarea',
            padding: const EdgeInsets.all(0),
            onPressed: () {
              onTaskDelete(task.id);
              print("Eliminando tarea ${task.id}");
            },
            icon: const Icon(Icons.delete_outline),
            color: Colors.red,
          )),
    );
  }
}
