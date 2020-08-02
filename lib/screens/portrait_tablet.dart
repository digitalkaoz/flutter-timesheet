import 'package:flutter/material.dart' hide Chip;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/widgets/app_bar.dart';
import 'package:timesheet_flutter/widgets/drawer.dart';
import 'package:timesheet_flutter/widgets/gradient.dart';
import 'package:timesheet_flutter/widgets/platform/scaffold.dart';
import 'package:timesheet_flutter/widgets/time_add_form.dart';

import '../services/theme.dart';
import 'client.dart';
import 'no_clients.dart';

class PortraitTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Clients clients = Provider.of<Clients>(context);

    return PlatformScaffold(
      navBar: NavBar(),
      drawer: ClientDrawer(),
      child: GradientContainer(
        child: Padding(
          padding: const EdgeInsets.only(
              top: kToolbarHeight + 16, left: 16, right: 16),
          child: Observer(
            builder: (_) => clients.hasClients
                ? Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Card(
                        color: bg(_),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(height: 24),
                            Text(
                              clients.current.currentTimesheet.isNewtime
                                  ? "New Time"
                                  : "Edit Time",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline
                                  .copyWith(color: Colors.white),
                            ),
                            TimeAddForm(columns: 2),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: ClientOverview(clients.current, secondary: true),
                      )
                    ],
                  )
                : NoClientsPage(),
          ),
        ),
      ),
    );
  }
}
