import 'package:flutter/material.dart' hide Chip;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/widgets/app_bar.dart';
import 'package:timesheet_flutter/widgets/drawer.dart';
import 'package:timesheet_flutter/widgets/platform/scaffold.dart';
import 'package:timesheet_flutter/widgets/time_add_form.dart';

import 'client.dart';
import 'no_clients.dart';

class PortraitTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Clients clients = Provider.of<Clients>(context);
    final PanelController sheet = Provider.of<PanelController>(context);

    return PlatformScaffold(
      navBar: NavBar(),
      drawer: ClientDrawer(),
      child: Observer(
        builder: (_) => clients.hasClients
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Card(
                    color: Theme.of(context).primaryColorDark,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 8),
                        Text(
                          clients.current.currentTimesheet.isNewtime
                              ? "New Time"
                              : "Edit Time",
                          style: Theme.of(context)
                              .textTheme
                              .headline
                              .copyWith(color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        TimeAddForm(columns: 2),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  ClientOverview(clients.current)
                ],
              )
            : NoClientsPage(),
      ),
    );
  }
}
