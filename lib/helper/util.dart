import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
class Utils {
  static String getDayOfWeek(DateTime date) => DateFormat('EEE').format(date);

  static String getDayOfMonth(DateTime date) => DateFormat('dd').format(date);

  static String getDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);
}


showSnackBar(String title, String message, Color backgroundColor) {
  Get.snackbar(title, message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: backgroundColor,
      colorText: Colors.white);
}
