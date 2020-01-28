import 'package:flutter/material.dart' hide Chip;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/widgets/app_bar.dart';
import 'package:timesheet_flutter/widgets/bottom_sheet.dart';
import 'package:timesheet_flutter/widgets/drawer.dart';
import 'package:timesheet_flutter/widgets/platform/chip.dart';
import 'package:timesheet_flutter/widgets/platform/scaffold.dart';
import 'package:timesheet_flutter/widgets/time_add_form.dart';

import 'client.dart';
import 'no_clients.dart';

class PortraitMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Clients clients = Provider.of<Clients>(context);
    final PanelController sheet = Provider.of<PanelController>(context);

    return PlatformScaffold(
      navBar: NavBar(),
      drawer: ClientDrawer(),
      child: Observer(
        builder: (_) => clients.hasClients
            ? SlidingBottomSheet(
                height: 70,
                controller: sheet,
                body: ClientOverview(clients.current),
                panel: clients.current == null
                    ? Container()
                    : bottomSheet(context, clients, sheet),
                collapsed: clients.current == null
                    ? Container()
                    : collapsed(clients, sheet),
              )
            : NoClientsPage(),
      ),
    );
  }

  Widget collapsed(Clients clients, PanelController sheet) {
    return Chip(
      onTap: () => sheet.isPanelOpen() ? sheet.close() : sheet.open(),
      label: Text('Add Time to ${clients.currentTitle}'),
    );
  }

  Widget bottomSheet(
      BuildContext context, Clients clients, PanelController sheet) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
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
          TimeAddForm(),
        ],
      ),
    );
  }
}
