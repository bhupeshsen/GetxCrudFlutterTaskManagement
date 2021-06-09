import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref {
  read(String key, bool isJson) async {
    final prefs = await SharedPreferences.getInstance();
    return isJson ? json.decode(prefs.getString(key)) : prefs.getString(key);
  }

  save(String key, value, bool isJson) async {
    final prefs = await SharedPreferences.getInstance();
    isJson ? prefs.setString(key, json.encode(value)) : prefs.setString(key, value);
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  clear() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}