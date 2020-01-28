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

    return Observer(
      builder: (_) => Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        height: 35,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Dropdown<Client>(
          value: clients.current,
          onChange: (dynamic selected) => selected.runtimeType == Client
              ? clients.setCurrent(selected)
              : clients.setCurrentIndex(selected),
          items: _buildClients(clients),
        ),
      ),
    );
  }

  List<DropdownMenuItem> _buildClients(Clients clients) {
    return clients.clients
        .map((client) => DropdownMenuItem(
              child: Center(
                child: Text(
                  client.name,
                  style: TextStyle(color: defaultColor),
                ),
              ),
              value: client,
              key: Key(client.name),
            ))
        .toList();
  }
}
