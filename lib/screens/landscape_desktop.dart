import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/screens/client.dart';
import 'package:timesheet_flutter/screens/no_clients.dart';
import 'package:timesheet_flutter/widgets/expanded_drawer.dart';

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
          child: ExpandedDrawer(),
        ),
        Flexible(
          flex: 7,
          fit: FlexFit.tight,
          child: Observer(
            builder: (_) => Scaffold(
              body: Container(
                color: Theme.of(context).canvasColor,
                child: clients.current == null
                    ? NoClientsPage()
                    : SingleChildScrollView(
                        child: ClientOverview(clients.current,
                            noBottomSheet: true),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
