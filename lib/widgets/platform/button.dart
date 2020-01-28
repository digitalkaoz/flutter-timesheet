import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as m show RaisedButton, FlatButton;
import 'package:flutter/widgets.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';

class RaisedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final Function() onPressed;

  const RaisedButton({Key key, this.color, this.onPressed, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (context) => CupertinoButton.filled(
        child: child,
        onPressed: onPressed,
      ),
      android: (context) => m.RaisedButton(
        child: child,
        color: color,
        onPressed: onPressed,
      ),
    );
  }
}

class Button extends StatelessWidget {
  final Widget child;
  final Color color;
  final Function() onPressed;

  const Button({Key key, this.color, this.onPressed, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (context) => CupertinoButton(
        child: child,
        onPressed: onPressed,
        color: color,
      ),
      android: (context) => m.FlatButton(
        child: child,
        color: color,
        onPressed: onPressed,
      ),
    );
  }
}
