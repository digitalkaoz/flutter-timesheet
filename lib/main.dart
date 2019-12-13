import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/screens/index.dart';
import 'package:timesheet_flutter/services/container.dart';
import 'package:timesheet_flutter/services/routes.dart';
import 'package:timesheet_flutter/services/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Timesheet',
        theme: theme,
        initialRoute: IndexScreen.ROUTE,
        routes: routes,
      ),
    );
  }
}
