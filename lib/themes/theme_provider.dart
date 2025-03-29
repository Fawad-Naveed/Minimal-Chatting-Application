import 'package:chatting/themes/dark_mode.dart';
import 'package:chatting/themes/light_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{

  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkmode;
  void toggleTheme() {
     _themeData = isDarkMode ? lightMode : darkmode;
    notifyListeners();
  }
  set themeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }
}