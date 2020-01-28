import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/screens/landscape_desktop.dart';
import 'package:timesheet_flutter/screens/landscape_mobile.dart';
import 'package:timesheet_flutter/screens/portrait_mobile.dart';
import 'package:timesheet_flutter/widgets/device.dart';
import 'package:timesheet_flutter/widgets/platform/spinner.dart';

class IndexScreen extends StatefulWidget {
  static const ROUTE = '/';

  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  bool loadedClients = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (loadedClients == false) {
      Provider.of<Clients>(context).load();
      loadedClients = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loadedClients == false) {
      return Material(
        child: Center(
          child: Spinner(),
        ),
      );
    }

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
