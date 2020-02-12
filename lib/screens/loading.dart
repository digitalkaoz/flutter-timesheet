import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/platform/spinner.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';

class LoadingPage extends StatelessWidget {
  Widget _content() {
    return Center(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          verticalDirection: VerticalDirection.down,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Timesheets"),
            SizedBox(height: 16),
            Spinner(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData(),
      child: PlatformWidget(
        ios: (_) => CupertinoTheme(
          data: WidgetsBinding.instance.window.platformBrightness ==
                  Brightness.dark
              ? iosthemeDark()
              : ios_theme(),
          child: Container(
            color: bg(_),
            child: _content(),
          ),
        ),
        android: (_) => Theme(
          data: WidgetsBinding.instance.window.platformBrightness ==
                  Brightness.dark
              ? themeDark()
              : theme(),
          child: Material(
            color: bg(_),
            child: _content(),
          ),
        ),
      ),
    );
  }
}
