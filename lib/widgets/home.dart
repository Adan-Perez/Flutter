import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
// Importo los widgets que he creado
import 'package:my_app/model/task.dart';
import 'package:my_app/widgets/task_item.dart';
import 'package:my_app/widgets/theme_notifier.dart';
import 'package:my_app/widgets/avatar_changer.dart';
import 'package:my_app/widgets/hello_world.dart';
import 'package:my_app/colors.dart';

// Clase que representa la pantalla principal de la aplicación (hereda de StatefulWidget)
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override // Crea el estado de la pantalla principal
  State<Home> createState() => _HomeState();
}

// Clase que representa el estado de la pantalla principal
class _HomeState extends State<Home> {
  final taskList = Task.taskList(); // Lista de tareas
  final _taskController =
      TextEditingController(); // Controlador del TextField (para añadir tareas)
  List<Task> _foundTasks = []; // Lista de tareas encontradas

  @override // Inicializo la lista de tareas encontradas con la lista de tareas (creadas en el modelo)
  void initState() {
    _foundTasks = taskList;
    super.initState();
  }

  // Método que construye la pantalla principal (obligatorio el método build para todos los widgets)
  @override
  Widget build(BuildContext context) {
    // Scaffold es un widget que representa la estructura básica de una pantalla (AppBar, body, etc.)
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            tooltip:
                context.watch<ThemeNotifier>().currentTheme == ThemeData.light()
                    ? 'Dark mode'
                    : 'Light mode',
            onPressed: () {
              context.read<ThemeNotifier>().toggleTheme();
            },
            icon: const Icon(Icons.lightbulb_outline),
          ),
          const HelloWorldButton()
        ],
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FlutterLogo(),
            Text(
              'My Tasks App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            AvatarChanger(),
          ],
        ),
        backgroundColor:
            context.watch<ThemeNotifier>().currentTheme == ThemeData.light()
                ? primaryColor
                : primaryColorDark,
      ),
      // Stack es un widget que permite apilar widgets (en este caso, el TextField y la lista de tareas)
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/kaneki-ken-background.jpg'),
                fit: BoxFit.cover,
                opacity: 0.5,
              ),
            ),
            // Column es un widget que permite apilar widgets en forma de columna
            child: Column(
              children: [
                searchBox(
                  context.watch<ThemeNotifier>().currentTheme,
                ),
                // Expanded es un widget que permite expandir un widget hijo para que ocupe todo el espacio disponible
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: const Text(
                          'Mis tareas 📝',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Recorro la lista de tareas encontradas y creo un widget TaskItem por cada tarea
                      for (Task task in _foundTasks.reversed)
                        TaskItem(
                          task: task,
                          onTaskToggle: _handleTaskChange,
                          onTaskDelete: _handleTaskDelete,
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
          // Align es un widget que permite alinear un widget hijo en una posición concreta
          Align(
            alignment: Alignment.bottomCenter,
            // Row es un widget que permite apilar widgets en forma de fila
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: context.watch<ThemeNotifier>().currentTheme ==
                            ThemeData.light()
                        ? Colors.grey[200]
                        : Colors.grey[600],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 3),
                      )
                    ],
                    border: Border.all(
                        color: context.watch<ThemeNotifier>().currentTheme ==
                                ThemeData.light()
                            ? Colors.black26
                            : Colors.white60),
                  ),
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      hintText: "Añadir tarea",
                      contentPadding: EdgeInsets.all(25),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.all(20),
                  child: FloatingActionButton(
                    onPressed: () {
                      addTask(_taskController.text);
                    },
                    child: const Icon(Icons.add),
                  )),
            ]),
          )
        ],
      ),
    );
  }

// Cambia el estado de una tarea (completa/incompleta)
  void _handleTaskChange(Task task) {
    setState(() {
      task.completed = !task.completed!;
    });
  }

// Elimina una tarea
  void _handleTaskDelete(String id) {
    setState(() {
      taskList.removeWhere((element) => element.id == id);

      _foundTasks = taskList;
    });
  }

// Añade una tarea
  void addTask(String title) {
    if (title.isEmpty) {
      title = 'No title ${const Uuid().v4()}';
    }
    setState(() {
      taskList.add(Task(
        id: const Uuid().v4().toString(),
        title: title,
      ));
    });

    _taskController.clear(); // Limpio el input después de agregar una tarea
  }

// Filtra las tareas según el texto introducido en el TextField
  void _filterToSearch(String query) {
    List<Task> results = [];
    if (query.isEmpty) {
      results = taskList;
    }
    results = taskList
        .where((element) =>
            element.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      _foundTasks = results;
    });
  }

// Widget que representa el TextField para buscar tareas
  Widget searchBox(ThemeData currentTheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: currentTheme == ThemeData.light()
            ? Colors.grey[200]
            : Colors.grey[600],
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) =>
            _filterToSearch(value), // Filtra las tareas mientras se escribe
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(15),
          border: InputBorder.none,
          hintText: 'Buscar',
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          prefixIcon: Icon(Icons.search),
          prefixIconConstraints: BoxConstraints(
            minWidth: 50,
          ),
        ),
      ),
    );
  }
}
