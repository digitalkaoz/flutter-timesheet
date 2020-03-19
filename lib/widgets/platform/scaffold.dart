import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';

class PlatformScaffold extends StatelessWidget {
  final Widget child;
  final Widget bottomBar;
  final Widget navBar;
  final Widget drawer;

  const PlatformScaffold(
      {Key key, this.child, this.bottomBar, this.navBar, this.drawer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (context) {
        return CupertinoPageScaffold(
          navigationBar: navBar,
          child: child,
        );
      },
      android: (context) => Scaffold(
        extendBodyBehindAppBar: true,
        drawer: drawer,
        appBar: navBar,
        body: child,
        bottomNavigationBar: bottomBar,
      ),
    );
  }
}
