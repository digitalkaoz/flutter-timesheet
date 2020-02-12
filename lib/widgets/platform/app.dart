import 'package:flutter/cupertino.dart' as c;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timesheet_flutter/screens/index.dart';
import 'package:timesheet_flutter/services/routes.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';

class PlatformApp extends StatefulWidget {
  static const String APP_TITLE = "Timesheet";
  static const String INITIAL_ROUTE = IndexScreen.ROUTE;

  @override
  _PlatformAppState createState() => _PlatformAppState();
}

class _PlatformAppState extends State<PlatformApp> with WidgetsBindingObserver {
  Brightness brightness;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    brightness = WidgetsBinding.instance.window.platformBrightness;
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (_) {
        if (brightness == null) {
          brightness = WidgetsBinding.instance.window.platformBrightness;
        }

        return c.CupertinoApp(
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          title: PlatformApp.APP_TITLE,
          theme: brightness == Brightness.dark ? iosthemeDark() : ios_theme(),
          initialRoute: PlatformApp.INITIAL_ROUTE,
          routes: routes,
        );
      },
      android: (_) {
        if (brightness == null) {
          brightness = WidgetsBinding.instance.window.platformBrightness;
        }
        return MaterialApp(
          title: PlatformApp.APP_TITLE,
          //theme: brightness == Brightness.dark ? themeDark() : theme(),
          theme: themeDark(),
          initialRoute: PlatformApp.INITIAL_ROUTE,
          routes: routes,
          //localizationsDelegates: ,
        );
      },
    );
  }
}
