import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final theme = ThemeData(
  primarySwatch: defaultColor,
  primaryColor: Color(0xff3f51b5),
  primaryColorBrightness: Brightness.dark,
  primaryColorLight: Color(0xffc5cae9),
  primaryColorDark: Color(0xff303f9f),
  accentColor: Color(0xff3f51b5),
  accentColorBrightness: Brightness.dark,
  canvasColor: Color(0xfffafafa),
  hintColor: Colors.white,
  inputDecorationTheme: InputDecorationTheme(
    focusColor: Colors.white,
    labelStyle: TextStyle(color: Colors.white),
    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    enabledBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    disabledBorder: InputBorder.none,
    contentPadding: EdgeInsets.only(left: 8, top: 4, bottom: 4),
  ),
);

final themeDark = ThemeData.dark().copyWith(
  accentColor: defaultColor,
  inputDecorationTheme: InputDecorationTheme(
    focusColor: Colors.white,
    prefixStyle: TextStyle(color: Colors.white),
    hintStyle: TextStyle(color: Colors.white),
    labelStyle: TextStyle(color: Colors.white),
    suffixStyle: TextStyle(color: Colors.white),
    border: OutlineInputBorder(),
    disabledBorder: InputBorder.none,
    contentPadding: EdgeInsets.only(left: 8, top: 4, bottom: 4),
  ),
  textTheme: TextTheme(
    display3: TextStyle(color: defaultColor),
    body1: TextStyle(color: defaultColor),
    subhead: TextStyle(color: Colors.white),
  ),
);

final defaultColor = Colors.indigo;

final CupertinoThemeData ios_theme = CupertinoThemeData(
  //primarySwatch: MaterialColor(0xf0000000, {}),
  brightness: Brightness.light,
  primaryColor: defaultColor,
  scaffoldBackgroundColor: Colors.grey[100],
);

invertedFormFieldWrapper(BuildContext context) => BoxDecoration(
      color: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).accentColor
          : Colors.white,
      borderRadius: BorderRadius.circular(20),
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
