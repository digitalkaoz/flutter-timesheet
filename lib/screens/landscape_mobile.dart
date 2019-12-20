import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/widgets/time_add_form.dart';

import 'client.dart';
import 'no_clients.dart';

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
                : SingleChildScrollView(
                    child: ClientOverview(clients.current),
                  ),
          ),
          Flexible(
            flex: 3,
            child: SingleChildScrollView(
              child: TimeAddForm(dense: true),
            ),
          )
        ],
      ),
    );
  }
}
