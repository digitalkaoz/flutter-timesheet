import 'package:flutter/material.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';

class Chip extends StatelessWidget {
  final Function() onTap;
  final Widget label;

  const Chip({Key key, this.onTap, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
        ios: (_) => GestureDetector(
              onTap: onTap,
              child: Material(
                color: Colors.transparent,
                child: _android(),
              ),
            ),
        android: (_) => _android());
  }

  Widget _android() {
    return ActionChip(
      onPressed: onTap,
      label: label,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(color: defaultColor),
    );
  }
}
