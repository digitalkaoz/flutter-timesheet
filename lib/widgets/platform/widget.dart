import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class PlatformWidget extends StatelessWidget {
  final Widget Function(BuildContext context) ios;
  final Widget Function(BuildContext context) android;

  const PlatformWidget({Key key, this.ios, this.android}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return ios(context);
      default:
        return android(context);
    }
  }
}

final isIos = defaultTargetPlatform == TargetPlatform.iOS;
final isAndroid = defaultTargetPlatform == TargetPlatform.android;
