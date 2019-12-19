import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/screens/client.dart';
import 'package:timesheet_flutter/screens/desktop_landscape.dart';
import 'package:timesheet_flutter/screens/no_clients.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/app_bar.dart';
import 'package:timesheet_flutter/widgets/bottom_sheet.dart';
import 'package:timesheet_flutter/widgets/device.dart';
import 'package:timesheet_flutter/widgets/drawer.dart';
import 'package:timesheet_flutter/widgets/time_add_form.dart';

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

    return Scaffold(
      appBar: NavBar(),
      drawer: ClientDrawer(),
      body: OrientationBuilder(
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
      ),
    );
  }
}

class PortraitMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Clients clients = Provider.of<Clients>(context);
    final PanelController sheet = Provider.of<PanelController>(context);

    return Observer(
      builder: (_) => Stack(
        children: <Widget>[
          clients.current == null
              ? NoClientsPage()
              : ClientOverview(clients.current),
          clients.current == null
              ? Container()
              : SlidingBottomSheet(
                  panel: SingleChildScrollView(
                    child: clients.current != null
                        ? Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                child: ActionChip(
                                  onPressed: () => sheet.isPanelOpen()
                                      ? sheet.close()
                                      : sheet.open(),
                                  label: Text(
                                      'Add Time to ${clients.currentTitle}'),
                                  backgroundColor: Colors.white,
                                  labelStyle: TextStyle(color: defaultColor),
                                ),
                              ),
                              TimeAddForm(),
                            ],
                          )
                        : Container(),
                  ),
                  controller: sheet,
                ),
        ],
      ),
    );
  }
}

class LandscapeMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Clients clients = Provider.of<Clients>(context);

    return Observer(
      builder: (_) => Row(
        children: <Widget>[
          Flexible(
            flex: 7,
            child: clients.current == null
                ? NoClientsPage()
                : SingleChildScrollView(child: ClientOverview(clients.current)),
          ),
          Flexible(
              flex: 3,
              child: SingleChildScrollView(child: TimeAddForm(dense: true)))
        ],
      ),
    );
  }
}
