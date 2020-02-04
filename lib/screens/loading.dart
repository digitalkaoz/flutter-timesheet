import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timesheet_flutter/widgets/platform/spinner.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';

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
