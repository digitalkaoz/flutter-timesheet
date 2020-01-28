import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';

class PlatformIcon extends StatelessWidget {
  final Icon icon;
  final Function() onTap;

  const PlatformIcon({Key key, this.icon, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (context) => GestureDetector(
        child: icon,
        onTap: onTap,
      ),
      android: (context) => IconButton(
        icon: icon,
        onPressed: onTap,
      ),
    );
  }
}
