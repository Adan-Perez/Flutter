import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import 'package:my_app/model/task.dart';
import 'package:my_app/widgets/task_item.dart';
import 'package:my_app/widgets/theme_notifier.dart';
import 'avatar_changer.dart';
import 'package:my_app/colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final taskList = Task.taskList();
  final _taskController = TextEditingController();
  List<Task> _foundTasks = [];

  @override
  void initState() {
    _foundTasks = taskList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          IconButton(
            tooltip: "Mensaje",
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("¡Hola, mundo!"),
                      content: const Text(
                          "Has presionado el botón, pero no hay nada más que hacer aquí. Por qué no intentas pulsar la imagen de perfil?"),
                      actions: [
                        TextButton(
                          child: const Text("Ok"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  });
            },
            icon: const Icon(Icons.adb),
          ),
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
            child: Column(
              children: [
                searchBox(
                  context.watch<ThemeNotifier>().currentTheme,
                ),
                // Lista de tareas
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
          Align(
            alignment: Alignment.bottomCenter,
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

  void _handleTaskChange(Task task) {
    setState(() {
      task.completed = !task.completed!;
    });
  }

  void _handleTaskDelete(String id) {
    setState(() {
      taskList.removeWhere((element) => element.id == id);

      _foundTasks = taskList;
    });
  }

  void addTask(String title) {
    setState(() {
      taskList.add(Task(
        id: const Uuid().v4().toString(),
        title: title,
      ));
    });

    _taskController.clear();
  }

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
        onChanged: (value) => _filterToSearch(value),
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
