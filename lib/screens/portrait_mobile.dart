import 'package:flutter/material.dart' hide Chip, RaisedButton, IconButton;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/app_bar.dart';
import 'package:timesheet_flutter/widgets/bottom_sheet.dart';
import 'package:timesheet_flutter/widgets/drawer.dart';
import 'package:timesheet_flutter/widgets/gradient.dart';
import 'package:timesheet_flutter/widgets/platform/button.dart';
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
      child: GradientContainer(
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
                      : _collapsed(clients, sheet, _),
                )
              : NoClientsPage(),
        ),
      ),
    );
  }

  Widget _collapsed(
      Clients clients, PanelController sheet, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: RaisedButton(
          onPressed: () => sheet.isPanelOpen() ? sheet.close() : sheet.open(),
          child: Text(
            'Add Time',
            style: textTheme(context),
          ),
        ),
      ),
    );
  }

  Widget bottomSheet(
      BuildContext context, Clients clients, PanelController sheet) {
    return SingleChildScrollView(
      child: Container(
        color: fg(context),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              clients.current.currentTimesheet.isNewtime
                  ? "New Time"
                  : "Edit Time",
              style: prettyTheme(context).copyWith(color: fgInverted(context)),
            ),
            SizedBox(height: 25),
            TimeAddForm(),
          ],
        ),
      ),
    );
  }
}
