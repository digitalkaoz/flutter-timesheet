import 'package:flutter/material.dart';
import 'package:timesheet_flutter/screens/desktop_landscape.dart';
import 'package:timesheet_flutter/screens/portrait_mobile.dart';
import 'package:timesheet_flutter/widgets/device.dart';

class IndexScreen extends StatelessWidget {
  static const ROUTE = '/';

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (_, Orientation orientation) {
        if (orientation == Orientation.landscape) {
          return DeviceWidget(
            phone: (_) => LandscapeMobile(),
            tablet: (_) => LandscapeMobile(),
            web: (_) => LandscapeDesktop(),
          );
        }

        return DeviceWidget(
          phone: (_) => PortraitMobile(),
          tablet: (_) => PortraitMobile(),
          web: (_) => PortraitMobile(),
        );
      },
    );
  }
}
