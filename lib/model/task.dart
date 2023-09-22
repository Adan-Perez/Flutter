// Clase que representa el modelo de datos de una tarea
class Task {
  String? id;
  String? title;
  bool? completed;

  Task({
    required this.id,
    required this.title,
    this.completed = false,
  });

  // Método que retorna una lista de tareas
  static List<Task> taskList() {
    return [
      Task(id: '01', title: "Hacer la compra semanal", completed: true),
      Task(id: '02', title: "Escuchar podcasts", completed: false),
      Task(id: '03', title: "Revisar documentación de Flutter"),
      Task(id: '04', title: "Contactar con el cliente"),
      Task(id: '05', title: "Escribir el correo del proyecto", completed: true)
    ];
  }
}
