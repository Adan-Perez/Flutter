import 'package:flutter/material.dart';

// Defino una clase ThemeNotifier que extiende ChangeNotifier para gestionar el estado del tema (en el main.dart)
class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme =
      ThemeData.light(); // Establece el tema inicial como claro

  ThemeData get currentTheme =>
      _currentTheme; // Getter para obtener el tema actual

  // Método para cambiar entre los temas claro y oscuro
  void toggleTheme() {
    _currentTheme = _currentTheme == ThemeData.light()
        ? ThemeData.dark()
        : ThemeData.light();
    notifyListeners(); // Notifica a los oyentes (listeners) que el tema ha cambiado
  }
}
