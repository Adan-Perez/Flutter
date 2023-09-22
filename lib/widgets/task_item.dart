import 'package:flutter/material.dart';
import 'package:my_app/model/task.dart';

// Clase que representa un elemento de la lista de tareas
class TaskItem extends StatelessWidget {
  final Task task; // Tarea a representar en el elemento de la lista
  final onTaskToggle; // Función para manejar la acción de cambiar el estado de la tarea
  final onTaskDelete; // Función para manejar la acción de eliminar la tarea

  // Constructor de TaskItem, debe tener una tarea (task) y dos funciones como parámetros opcionales
  const TaskItem(
      {Key? key, required this.task, this.onTaskToggle, this.onTaskDelete})
      : super(key: key);

  // Método que construye el elemento de la lista de tareas
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ListTile(
          onTap: () {
            onTaskToggle(task);
          }, // Llama a la función onTaskToggle cuando se toca el ListTile
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
            task.title!,
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
            }, // Llama a la función onTaskDelete cuando se toca el IconButton
            icon: const Icon(Icons.delete_outline),
            color: Colors.red,
          )),
    );
  }
}
