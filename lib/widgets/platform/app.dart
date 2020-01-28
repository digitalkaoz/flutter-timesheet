import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timesheet_flutter/screens/index.dart';
import 'package:timesheet_flutter/services/routes.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';

class PlatformApp extends StatelessWidget {
  static const String APP_TITLE = "Timesheet";
  static const String INITIAL_ROUTE = IndexScreen.ROUTE;

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (context) => CupertinoApp(
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        title: APP_TITLE,
        theme: ios_theme,
        initialRoute: INITIAL_ROUTE,
        routes: routes,
      ),
      android: (context) => MaterialApp(
        title: APP_TITLE,
        theme: theme,
        initialRoute: INITIAL_ROUTE,
        routes: routes,
        //localizationsDelegates: ,
      ),
    );
  }
}
