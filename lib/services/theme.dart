import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final theme = ThemeData(
  primarySwatch: Colors.blue,
  floatingActionButtonTheme: FloatingActionButtonThemeData(),
);

const defaultColor = Colors.blue;

final invertedFormFieldWrapper =
    BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20));

const invertedFormField = InputDecoration(
  fillColor: Colors.white,
  border: InputBorder.none,
  filled: true,
);

String durationFormat(Duration duration) {
  if (duration == null) {
    return '0:00';
  }
  return duration.toString().substring(0, duration.toString().lastIndexOf(':'));
}

String dateFormat(DateTime date) {
  if (date == null) {
    return DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(DateTime.now());
  }
  return DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(date);
}
