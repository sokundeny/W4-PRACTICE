import 'package:flutter/material.dart';

enum ThemeColor {
  blue(color: Color.fromARGB(255, 34, 118, 229)),
  green(color: Color.fromARGB(255, 229, 158, 221)),
  pink(color: Color.fromARGB(255, 156, 202, 8));

  const ThemeColor({required this.color});

  final Color color;
  Color get backgroundColor => color.withAlpha(100);
}

class ThemeColorProvider extends ChangeNotifier {

  ThemeColor _currentTheme = ThemeColor.blue;

  ThemeColor get currentTheme => _currentTheme;

  Color get mainColor => _currentTheme.color;
  Color get backgroundColor => _currentTheme.backgroundColor;

  void setTheme(ThemeColor theme) {
    _currentTheme = theme;
    notifyListeners();
  }
}

final themeProvider = ThemeColorProvider();

