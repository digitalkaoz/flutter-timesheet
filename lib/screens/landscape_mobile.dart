import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/app_bar.dart';
import 'package:timesheet_flutter/widgets/drawer.dart';
import 'package:timesheet_flutter/widgets/gradient.dart';
import 'package:timesheet_flutter/widgets/platform/scaffold.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';
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
      child: GradientContainer(
        child: Observer(
          builder: (_) => clients.hasClients
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 0,
                            top: isIos ? 0 : 14,
                            bottom: isIos ? 0 : 14),
                        child: ClientOverview(
                          clients.current,
                          noBottomSheet: true,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: 14,
                            top: kToolbarHeight + (isIos ? -4 : 10),
                            bottom: isIos ? 16 : 10),
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
