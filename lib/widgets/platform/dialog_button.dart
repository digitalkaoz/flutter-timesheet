import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';

class DialogButton extends StatelessWidget {
  final Function() onTap;
  final bool primary;
  final Widget child;

  const DialogButton({
    Key key,
    this.onTap,
    this.primary = false,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (_) => CupertinoDialogAction(
        onPressed: onTap,
        isDefaultAction: primary,
        child: child,
      ),
      android: (_) => FlatButton(
        onPressed: onTap,
        child: child,
      ),
    );
  }
}
