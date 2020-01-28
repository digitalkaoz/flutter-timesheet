import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';

class Page extends StatelessWidget {
  final Widget child;

  const Page({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (context) => Container(
        color: Colors.white.withOpacity(0.97),
        child: child,
      ),
      android: (context) => Material(
        child: child,
      ),
    );
  }
}
