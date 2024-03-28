import 'package:flutter/material.dart';

// Светлая тема с использованием Orange: Colors.orange
ThemeData lightTheme = ThemeData(
  primaryColor: Colors.orange, // Основной цвет для верхней панели приложения в светлой теме
  colorScheme: ColorScheme.light(
    secondary: Colors.orangeAccent, // Цвет акцента в светлой теме
  ),
  scaffoldBackgroundColor: Colors.white, // Цвет фона экранов в светлой теме
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.orange, // Цвет верхней панели приложения в светлой теме
  ),
);

// Темная тема с использованием Orange: Colors.orange
ThemeData darkTheme = ThemeData(
  primaryColor: Colors.orange, // Основной цвет для верхней панели приложения в темной теме
  colorScheme: ColorScheme.dark(),
  scaffoldBackgroundColor: Colors.grey[900], // Цвет фона экранов в темной теме
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.orange, // Цвет верхней панели приложения в темной теме
  ),
);


// Кастомная тема
ThemeData customTheme = ThemeData(
  primaryColor: Colors.green, // Пример цвета для верхней панели приложения в кастомной теме
  colorScheme: ColorScheme.light(
    secondary: Colors.orange, // Пример цвета для акцентных элементов в кастомной теме
  ),
  scaffoldBackgroundColor: Colors.grey[200], // Пример цвета фона экранов в кастомной теме
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.green, // Пример цвета верхней панели приложения в кастомной теме
  ),
);

// Смена темы
class ThemeNotifier extends ChangeNotifier {
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  void toggleTheme() {
    _darkTheme = !_darkTheme;
    notifyListeners();
  }
}