import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/screens/client.dart';
import 'package:timesheet_flutter/screens/no_clients.dart';

class ClientPages extends StatelessWidget {
  final PageController _pager = PageController(keepPage: false);

  @override
  Widget build(BuildContext context) {
    final Clients clients = Provider.of<Clients>(context);
    return Observer(
      builder: (_) => !clients.hasClients
          ? NoClientsPage()
          : PageView(
              controller: _pager,
              onPageChanged: (int index) => clients.setCurrent(index),
              children: clients.clients
                  .map((Client client) => ClientOverview(client))
                  .toList(),
            ),
    );
  }
}
