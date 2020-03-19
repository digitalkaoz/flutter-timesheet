import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';

class DialogButton extends StatelessWidget {
  final Function() onTap;
  final bool primary;
  final Widget child;
  final Color color;

  const DialogButton({
    Key key,
    this.onTap,
    this.primary = false,
    this.child,
    this.color,
  }) : super(key: key);

  ShapeBorder _shape() {
    if (primary && color != null) {
      return RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));
    }

    if (color != null && !primary) {
      return OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: color));
    }
  }

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
        shape: _shape(),
        color: color != null && !primary ? Colors.transparent : color,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: child,
        ),
      ),
    );
  }
}
