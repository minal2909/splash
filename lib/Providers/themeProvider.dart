import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  bool _darkTheme;

  SettingsProvider() {
    _darkTheme = false;
    clearPreferences();
    loadPreferences();
  }

  //Getters
  bool get darkTheme => _darkTheme;

  //Setters
  void setTheme(bool theme) {
    _darkTheme = theme;
    notifyListeners();
    savePreferences();
  }

  savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('_darkTheme', _darkTheme);
  }

  loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _darkTheme = prefs.getBool('_darkTheme');
    if (_darkTheme != null) setTheme(_darkTheme);
  }

  clearPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
