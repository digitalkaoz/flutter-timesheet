import 'package:flutter/widgets.dart';
import 'package:timesheet_flutter/services/theme.dart';

class Logo extends StatelessWidget {
  final double size;

  const Logo({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "logo",
      child: Text(
        "Timesheets",
        style: logoTheme(context).copyWith(fontSize: size),
      ),
    );
  }
}
