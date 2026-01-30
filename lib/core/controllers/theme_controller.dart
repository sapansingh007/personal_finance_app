import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();
  
  final SharedPreferences _prefs;
  
  ThemeController(this._prefs);
  
  // Theme mode observable
  final _isDarkMode = false.obs;
  bool get isDarkMode => _isDarkMode.value;
  
  // Theme mode getter for MaterialApp
  ThemeMode get themeMode => _isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
  
  @override
  void onInit() {
    super.onInit();
    _loadThemeFromPrefs();
  }
  
  void _loadThemeFromPrefs() {
    final isDark = _prefs.getBool('isDarkMode') ?? false;
    _isDarkMode.value = isDark;
  }
  
  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    _saveThemeToPrefs();
    update(); // Trigger GetBuilder rebuild
  }
  
  void _saveThemeToPrefs() {
    _prefs.setBool('isDarkMode', _isDarkMode.value);
  }
  
  void setThemeMode(bool isDark) {
    _isDarkMode.value = isDark;
    _saveThemeToPrefs();
    update(); // Trigger GetBuilder rebuild
  }
}
