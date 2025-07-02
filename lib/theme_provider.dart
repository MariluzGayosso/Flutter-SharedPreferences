import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkTheme = false;
  double _fontSize = 16.0;
  MaterialColor _primaryColor = Colors.blue;
  String _name = '';
  String _lastname = '';
  String _email = '';
  String _phone = '';
  String _age = '';
  String _gender = 'otro';

  bool get isDarkTheme => _isDarkTheme;
  double get fontSize => _fontSize;
  MaterialColor get primaryColor => _primaryColor;
  String get name => _name;
  String get lastname => _lastname;
  String get email => _email;
  String get phone => _phone;
  String get age => _age;
  String get gender => _gender;

  ThemeProvider() {
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    _fontSize = prefs.getDouble('fontSize') ?? 16.0;
    _primaryColor = _colorFromString(prefs.getString('primaryColor') ?? 'blue');
    _name = prefs.getString('name') ?? '';
    _lastname = prefs.getString('lastame') ?? '';
    _email = prefs.getString('email') ?? '';
    _phone = prefs.getString('phone') ?? '';
    _age = prefs.getString('age') ?? '';
    _gender = prefs.getString('gender') ?? 'otro';
    notifyListeners();
  }

  void toggleTheme(bool value) async {
    _isDarkTheme = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', value);
    notifyListeners();
  }

  void setFontSize(double value) async {
    _fontSize = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('fontSize', value);
    notifyListeners();
  }

  void setPrimaryColor(MaterialColor color) async {
    _primaryColor = color;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('primaryColor', _colorToString(color));
    notifyListeners();
  }

  void setUserData(String name, String lastname, String email, String phone, String age, String gender) async {
    _name = name;
    _lastname = lastname;
    _email = email;
    _phone = phone;
    _age = age;
    _gender = gender;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
    prefs.setString('lastname', lastname);
    prefs.setString('email', email);
    prefs.setString('phone', phone);
    prefs.setString('age', age);
    prefs.setString('gender', gender);
    notifyListeners();
  }

  void resetPreferences() async {
    _isDarkTheme = false;
    _fontSize = 16.0;
    _primaryColor = Colors.blue;
    _name = '';
    _lastname = '';
    _email = '';
    _phone = '';
    _age = '';
    _gender = 'otro';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }

  String _colorToString(MaterialColor color) {
    if (color == Colors.red) return 'red';
    if (color == Colors.green) return 'green';
    if (color == Colors.purple) return 'purple';
    if (color == Colors.pink) return 'pink';
    return 'blue';
  }

  MaterialColor _colorFromString(String color) {
    switch (color) {
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'purple':
        return Colors.purple;
      case 'pink':
        return Colors.pink;
      default:
        return Colors.blue;
    }
  }
}
