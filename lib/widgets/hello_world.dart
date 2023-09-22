import 'package:flutter/material.dart';

// Defino un widget llamado HelloWorldButton que muestra un botón "Hello, world!"
class HelloWorldButton extends StatelessWidget {
  const HelloWorldButton({Key? key}) : super(key: key);

  // Construyo el widget con un botón que muestra un diálogo al pulsarlo
  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: "Mensaje",
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("¡Hola, mundo!"),
                content: const Text(
                    "Has presionado el botón, pero no hay nada más que hacer aquí. \n¿Por qué no intentas pulsar la imagen de perfil?"),
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
    );
  }
}
