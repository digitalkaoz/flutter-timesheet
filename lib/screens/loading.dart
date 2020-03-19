import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/logo.dart';
import 'package:timesheet_flutter/widgets/platform/app.dart';
import 'package:timesheet_flutter/widgets/platform/spinner.dart';

class LoadingPage extends StatelessWidget {
  Widget _content(BuildContext context) {
    return Container(
      color: bg(context),
      child: Center(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            verticalDirection: VerticalDirection.down,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Logo(),
              SizedBox(height: 16),
              Spinner(
                color: brightness(context) == Brightness.dark
                    ? accent(context)
                    : Colors.white,
                width: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformApp(home: _content(context));
  }
}
