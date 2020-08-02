import 'package:flutter/widgets.dart';
import 'package:timesheet_flutter/services/theme.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;

  const GradientContainer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          stops: [0.27, 0.7],
          end: Alignment.topRight,
          colors: [gradientStart(context), gradientEnd(context)],
        ),
      ),
      child: child,
    );
  }
}
