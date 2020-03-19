import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';

class Spinner extends StatelessWidget {
  final Color color;
  final double width;

  const Spinner({Key key, this.color: Colors.black, this.width = 3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (context) => _IosSpinner(),
      android: (context) => _MaterialSpinner(
        width: width,
        color: color,
      ),
    );
  }
}

class _IosSpinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator();
  }
}

class _MaterialSpinner extends StatelessWidget {
  final Color color;
  final double width;

  const _MaterialSpinner({Key key, this.color, this.width = 3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: width,
          valueColor: AlwaysStoppedAnimation(color),
        ),
      ),
    );
  }
}
