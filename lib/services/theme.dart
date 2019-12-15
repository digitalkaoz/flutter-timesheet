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
    return '00:00';
  }
  return duration
      .toString()
      .substring(0, duration.toString().lastIndexOf(':'))
      .padLeft(5, '0');
}

String timeFormat(TimeOfDay time) {
  if (time == null) {
    return '00:00';
  }
  return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
}

String dateFormat(DateTime date) {
  if (date == null) {
    return DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(DateTime.now());
  }
  return DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(date);
}
