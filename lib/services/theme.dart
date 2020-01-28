import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final theme = ThemeData(
  primarySwatch: defaultColor,
  canvasColor: Colors.grey[100],
);

const defaultColor = Colors.blue;

final CupertinoThemeData ios_theme = CupertinoThemeData(
  //primarySwatch: MaterialColor(0xf0000000, {}),
  brightness: Brightness.light,
  primaryColor: defaultColor,
  scaffoldBackgroundColor: Colors.grey[100],
);

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
