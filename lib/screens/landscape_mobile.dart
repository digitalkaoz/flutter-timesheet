import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/app_bar.dart';
import 'package:timesheet_flutter/widgets/drawer.dart';
import 'package:timesheet_flutter/widgets/platform/scaffold.dart';
import 'package:timesheet_flutter/widgets/time_add_form.dart';

import 'client.dart';
import 'no_clients.dart';

class LandscapeMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Clients clients = Provider.of<Clients>(context);

    return PlatformScaffold(
      navBar: NavBar(),
      drawer: ClientDrawer(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            stops: [0.27, 0.7],
            end: Alignment.topRight,
            colors: [gradientStart(context), gradientEnd(context)],
          ),
        ),
        child: Observer(
          builder: (_) => clients.hasClients
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, top: 6),
                          child: ClientOverview(
                            clients.current,
                            noBottomSheet: true,
                          ),
                        )),
                    Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 4, top: kToolbarHeight),
                        child: Card(
                          color: bg(_),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                SizedBox(height: 12),
                                Text(
                                  clients.current.currentTimesheet.isNewtime
                                      ? "New Time"
                                      : "Edit Time",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline
                                      .copyWith(color: Colors.white),
                                ),
                                SizedBox(height: 12),
                                TimeAddForm(
                                  columns: 1,
                                  dense: true,
                                ),
                              ],
                            ),
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
