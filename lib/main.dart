import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timesheet_flutter/services/container.dart';
import 'package:timesheet_flutter/widgets/platform/app.dart';
import 'package:timesheet_flutter/widgets/platform/spinner.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';

void main() => runApp(TimesheetApp());

class TimesheetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snap) {
        if (ConnectionState.done != snap.connectionState) {
          return LoadingPage();
        }

        return MultiProvider(
          providers: createProviders(snap.data),
          child: PlatformApp(),
        );
      },
    );
  }
}

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (_) => CupertinoApp(
        home: Container(
          child: Center(
            child: Spinner(),
          ),
        ),
      ),
      android: (_) => MaterialApp(
        home: Material(
          child: Center(
            child: Spinner(),
          ),
        ),
      ),
    );
  }
}
