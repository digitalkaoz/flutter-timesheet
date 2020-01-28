import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';

class Link extends StatelessWidget {
  final Widget child;
  final Color color;
  final Function() onPressed;

  const Link({Key key, this.color, this.onPressed, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (context) => CupertinoButton(
        child: child,
        color: color,
        onPressed: onPressed,
      ),
      android: (context) => FlatButton(
        color: color,
        child: child,
        onPressed: onPressed,
      ),
    );
  }
}
