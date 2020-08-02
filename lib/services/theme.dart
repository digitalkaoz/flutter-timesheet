import 'package:flutter/cupertino.dart' as c;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';

final darkColor = Color(0xff01A39D);
final accentColor = Colors.orange[600];
final accentDark = Color(0xffF6CF94);

final gradientStart = (BuildContext context) =>
    brightness(context) == Brightness.dark ? Colors.grey[900] : darkColor;

final gradientEnd = (BuildContext context) =>
    brightness(context) == Brightness.dark
        ? Colors.grey[700]
        : Color(0xff22EED5);

final logoTheme = (BuildContext context) => GoogleFonts.pacifico(
    textStyle: Theme.of(context).textTheme.headline.copyWith(
        color: brightness(context) == Brightness.dark
            ? accent(context)
            : Colors.white,
        fontSize: 50));

final prettyTheme = (BuildContext context) => GoogleFonts.signika(
    textStyle: Theme.of(context).textTheme.caption.copyWith(
        color: brightness(context) == Brightness.dark
            ? accent(context)
            : Colors.white,
        fontSize: 25));

final textTheme = (BuildContext context) => GoogleFonts.signika(
      textStyle: Theme.of(context).textTheme.caption.copyWith(
          fontWeight: FontWeight.w200,
          color: brightness(context) == Brightness.dark
              ? Colors.grey[900]
              : Colors.white,
          fontSize: 15),
    );

final textThemeInverted = (BuildContext context) => GoogleFonts.signika(
      textStyle: Theme.of(context).textTheme.caption.copyWith(
          fontWeight: FontWeight.w200,
          color: brightness(context) == Brightness.dark
              ? Colors.white
              : fg(context),
          fontSize: 15),
    );

ThemeData androidThemeLight(BuildContext context) => ThemeData(
      primaryColor: darkColor,
      accentColor: accentColor,
      iconTheme: IconThemeData(color: darkColor),
      brightness: Brightness.light,
      hintColor: darkColor,
      textTheme: GoogleFonts.signikaTextTheme(Theme.of(context).textTheme),
      inputDecorationTheme: InputDecorationTheme(
        focusColor: darkColor,
        errorStyle: GoogleFonts.signika().copyWith(color: accentColor),
        labelStyle: GoogleFonts.signika()
            .copyWith(color: Colors.white.withOpacity(0.5)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(0.5))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: darkColor.withOpacity(0.5))),
        disabledBorder: InputBorder.none,
        focusedErrorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: accentColor)),
        errorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: accentColor)),
        contentPadding: EdgeInsets.only(left: 8, top: 4, bottom: 4),
      ),
    );

ThemeData androidThemeDark(BuildContext context) => ThemeData.dark().copyWith(
      accentColor: accentDark,
      iconTheme: IconThemeData(color: accentDark),
      brightness: Brightness.dark,
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
      textTheme: GoogleFonts.signikaTextTheme(TextTheme(
        button: TextStyle(color: Colors.white),
        display3: TextStyle(color: accentColor),
        body1: TextStyle(color: accentColor),
        subhead: TextStyle(color: accentColor),
      )),
    );

c.CupertinoThemeData iosThemeLight(BuildContext context) =>
    MaterialBasedCupertinoThemeData(materialTheme: androidThemeLight(context))
        .copyWith(
      brightness: Brightness.light,
      barBackgroundColor: darkColor,
      primaryContrastingColor: accentColor,
      scaffoldBackgroundColor: Colors.grey[300],
    );

c.CupertinoThemeData iosThemeDark(BuildContext context) =>
    MaterialBasedCupertinoThemeData(materialTheme: androidThemeDark(context))
        .copyWith(
      barBackgroundColor: Colors.grey[900],
      brightness: Brightness.dark,
      primaryContrastingColor: accentDark,
      scaffoldBackgroundColor: Colors.grey[800],
    );

Color bg(BuildContext context) {
  return brightness(context) == Brightness.dark ? Colors.grey[900] : darkColor;
}

TextStyle text(BuildContext context) {
  return textTheme(context).copyWith(color: fg(context));
}

Brightness brightness(BuildContext context) {
  if (isIos) {
    return c.CupertinoTheme.of(context).brightness;
  }

  return Theme.of(context).brightness;
}

Color accent(BuildContext context) {
  return brightness(context) == Brightness.dark ? accentDark : accentColor;
}

Color fg(BuildContext context) {
  return brightness(context) == Brightness.dark ? Colors.grey[900] : darkColor;
}

Color fgInverted(BuildContext context) {
  return brightness(context) == Brightness.dark ? accentDark : Colors.white;
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
