import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'widgets/home.dart';
import 'widgets/theme_notifier.dart';

void main() {
  runApp(const MyApp());
}

// Defino la clase MyApp que es un StatelessWidget (no puede cambiar de estado)

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Construyo el widget con un MaterialApp que contiene el tema y la página principal
  @override
  Widget build(BuildContext context) {
    // Cambio el color de la barra de estado
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    );

    // Devuelvo un ChangeNotifierProvider que contiene el tema y un Builder que contiene el MaterialApp
    return ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'My Tasks App',
            theme: context.watch<ThemeNotifier>().currentTheme,
            home: const Home(),
          );
        },
      ),
    );
  }
}
