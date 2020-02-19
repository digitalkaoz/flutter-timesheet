import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';

final darkColor = Color(0xff00acc1);
final accentColor = Color(0xff1a237e);

ThemeData theme() => ThemeData(
      primaryColor: darkColor,
      accentColor: accentColor,
      iconTheme: IconThemeData(color: darkColor),
      canvasColor: Color(0xfffafafa),
      hintColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        focusColor: Colors.white,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(0.5))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(0.5))),
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.only(left: 8, top: 4, bottom: 4),
      ),
    );

themeDark() => ThemeData.dark().copyWith(
      accentColor: accentColor,
      iconTheme: IconThemeData(color: accentColor),
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
        button: TextStyle(color: Colors.white),
        display3: TextStyle(color: accentColor),
        body1: TextStyle(color: accentColor),
        subhead: TextStyle(color: accentColor),
      ),
    );

CupertinoThemeData ios_theme() =>
    MaterialBasedCupertinoThemeData(materialTheme: theme()).copyWith(
      barBackgroundColor: darkColor,
      primaryContrastingColor: accentColor,
      scaffoldBackgroundColor: Colors.grey[300],
    );

CupertinoThemeData iosthemeDark() =>
    MaterialBasedCupertinoThemeData(materialTheme: themeDark()).copyWith(
      barBackgroundColor: Colors.grey[900],
      brightness: Brightness.dark,
      primaryContrastingColor: accentColor,
      scaffoldBackgroundColor: Colors.grey[800],
    );

Color bg(BuildContext context) {
  return brightness(context) == Brightness.dark ? Colors.grey[900] : darkColor;
}

Brightness brightness(BuildContext context) {
  if (isIos) {
    return CupertinoTheme.of(context).brightness;
  }

  return Theme.of(context).brightness;
}

Color accent(BuildContext context) {
  return brightness(context) == Brightness.dark
      ? Color(0xffffe0b2)
      : accentColor;
}

Color fg(BuildContext context) {
  return brightness(context) == Brightness.dark ? Colors.grey[900] : darkColor;
}

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
