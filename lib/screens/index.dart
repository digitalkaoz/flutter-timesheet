import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/screens/landscape_desktop.dart';
import 'package:timesheet_flutter/screens/landscape_mobile.dart';
import 'package:timesheet_flutter/screens/portrait_mobile.dart';
import 'package:timesheet_flutter/widgets/device.dart';

class IndexScreen extends StatefulWidget {
  static const ROUTE = '/';

  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  Future<void> loadedClients;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (loadedClients == null) {
      loadedClients = Provider.of<Clients>(context).load();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadedClients,
      builder: (_, AsyncSnapshot future) {
        if (ConnectionState.done != future.connectionState) {
          return Center(
            child: CircularProgressIndicator(),
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
      },
    );
  }
}
