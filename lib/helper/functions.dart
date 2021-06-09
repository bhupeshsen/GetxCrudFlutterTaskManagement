import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

bool isValidEmail(email) {
  return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

double roundDouble(double value, int places) {
  double mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

String convertDate(DateTime date) {
  return DateFormat('MMM d, yyyy').format(date);
}
String convertDateTimeTwo(DateTime date) {
  return DateFormat('yyyy-MM-d').format(date);
}

String convertTime(BuildContext context, TimeOfDay time) {
  return time.format(context);
}

String convertTimeDate(BuildContext context, TimeOfDay t) {
  // return TimeOfDay(hour: time.hourOfPeriod, minute: time.minute)
  //     .format(context);
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day, t.hour, t.minute).toString();
}

TimeOfDay parseTimeOfDay(String time) {
  return TimeOfDay(
      hour: int.parse(time.split(":")[0]),
      minute: int.parse(time.split(":")[1]));
}

String convertDateTime(DateTime date) {
  return DateFormat('MMM d, yyyy at HH:mm').format(date);
}

String initialValueInt(int value) {
  return value != null ? value.toString() : '';
}

String convertToYear(DateTime date) {
  return DateFormat('yyyy').format(date);
}

String arrayToString(array) {
  if (array == null) {
    return '';
  }
  return array.toString().replaceAll('[', '').replaceAll(']', '');
}

void removeUpdateField(Map map) {
  map.remove('_id');
  map.remove('createdAt');
  map.remove('updatedAt');
  map.remove('deleted');
  map.remove('verified');
  map.remove('userType');
  map.remove('password');
}

String getFileExtensionFromUrl(String url) {
  url = url.split('?')[0];
  url = url.split('/').last;
  return url.contains('.') ? url.substring(url.lastIndexOf('.')) : "";
}

String getHumanReadableFileSize(int bytes) {
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return ((bytes / pow(1024, i)).toStringAsFixed(1)) + ' ' + suffixes[i];
}

String getFileSize(int bytes) {
  if (bytes <= 0) return '0';
  var i = (log(bytes) / log(1024)).floor();
  return ((bytes / pow(1024, i)).toStringAsFixed(1));
}
