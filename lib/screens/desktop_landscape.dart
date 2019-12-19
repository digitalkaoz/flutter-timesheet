import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/screens/client.dart';
import 'package:timesheet_flutter/screens/no_clients.dart';
import 'package:timesheet_flutter/widgets/app_bar.dart';
import 'package:timesheet_flutter/widgets/drawer.dart';
import 'package:timesheet_flutter/widgets/time_add_form.dart';

class LandscapeDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Clients clients = Provider.of<Clients>(context);

    return Flex(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      direction: Axis.horizontal,
      children: <Widget>[
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: ClientDrawer(
            child: TimeAddForm(dense: true),
          ),
        ),
        Flexible(
          flex: 7,
          fit: FlexFit.tight,
          child: Observer(
            builder: (_) => Scaffold(
              appBar: NavBar(),
              body: Container(
                color: Colors.grey[100],
                child: clients.current == null
                    ? NoClientsPage()
                    : SingleChildScrollView(
                        child: ClientOverview(clients.current),
                      ),
              ),
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: NavBar(),
//			drawer: ClientDrawer(),
      body: Observer(
        builder: (_) => Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height - kToolbarHeight,
                    child: ClientDrawer(),
                  ),
                  TimeAddForm(dense: true),
                ],
              ),
            ),
            Flexible(
              flex: 7,
              child: clients.current == null
                  ? NoClientsPage()
                  : SingleChildScrollView(
                      child: ClientOverview(clients.current)),
            ),
          ],
        ),
      ),
    );

    return Observer(
      builder: (_) => Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            flex: 7,
            child: clients.current == null
                ? NoClientsPage()
                : SingleChildScrollView(child: ClientOverview(clients.current)),
          ),
          Flexible(
              flex: 3,
              child: SingleChildScrollView(
                  child: Container(
                      height:
                          MediaQuery.of(context).size.height - kToolbarHeight,
                      child: TimeAddForm(dense: true))))
        ],
      ),
    );
  }
}
