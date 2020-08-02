import 'package:flutter/material.dart' hide Chip;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/app_bar.dart';
import 'package:timesheet_flutter/widgets/drawer.dart';
import 'package:timesheet_flutter/widgets/gradient.dart';
import 'package:timesheet_flutter/widgets/platform/scaffold.dart';
import 'package:timesheet_flutter/widgets/time_add_form.dart';

import 'client.dart';
import 'no_clients.dart';

class LandscapeTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Clients clients = Provider.of<Clients>(context);

    return PlatformScaffold(
      navBar: NavBar(),
      drawer: ClientDrawer(),
      child: GradientContainer(
        child: Observer(
          builder: (_) => clients.hasClients
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, top: 4),
                          child: ClientOverview(clients.current,
                              noBottomSheet: true),
                        )),
                    SizedBox(width: 12),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: kToolbarHeight + 28, right: 12, bottom: 12),
                        child: Card(
                          color: bg(_),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(height: 32),
                              Text(
                                clients.current.currentTimesheet.isNewtime
                                    ? "New Time"
                                    : "Edit Time",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline
                                    .copyWith(color: Colors.white),
                              ),
                              SizedBox(height: 32),
                              TimeAddForm(columns: 1),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : NoClientsPage(),
        ),
      ),
    );
  }
}
