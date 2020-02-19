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
              child: Material(
                color: Colors.transparent,
                child: _android(_),
              ),
            ),
        android: (_) => _android(_));
  }

  Widget _android(_) {
    return ActionChip(
      onPressed: onTap,
      label: label,
      backgroundColor: bg(_),
      shape: StadiumBorder(side: BorderSide(color: accent(_), width: 2)),
      //backgroundColor: Theme.of(_).accentColor,
      labelStyle: Theme.of(_)
          .textTheme
          .caption
          .copyWith(fontWeight: FontWeight.bold, color: accent(_)),
    );
  }
}
