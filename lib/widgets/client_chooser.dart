import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/platform/dropdown_field.dart';

class ClientChooser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Clients clients = Provider.of<Clients>(context);

    if (clients.current == null) {
      return Container();
    }

    final color = accent(context);

    return Observer(
      builder: (_) => Dropdown<Client>(
        value: clients.current,
        onChange: (dynamic selected) => selected.runtimeType == Client
            ? clients.setCurrent(selected)
            : clients.setCurrentIndex(selected),
        items: _buildClients(clients, _, color),
      ),
    );
  }

  List<DropdownMenuItem> _buildClients(
      Clients clients, BuildContext context, Color color) {
    return clients.clients
        .map((client) => DropdownMenuItem(
              child: Center(
                child: Text(
                  client.name,
                  style: TextStyle(color: accent(context)),
                ),
              ),
              value: client,
              key: Key(client.name),
            ))
        .toList();
  }
}
