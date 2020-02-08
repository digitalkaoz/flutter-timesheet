import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timesheet_flutter/screens/loading.dart';
import 'package:timesheet_flutter/services/container.dart';
import 'package:timesheet_flutter/widgets/platform/app.dart';

void _setTargetPlatformForDesktop() {
  // No need to handle macOS, as it has now been added to TargetPlatform.
  if (Platform.isLinux || Platform.isWindows) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() {
  _setTargetPlatformForDesktop();
  runApp(TimesheetApp());
}

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
