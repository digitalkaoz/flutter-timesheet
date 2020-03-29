import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/platform/dropdown_field.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';

class ClientChooser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Clients clients = Provider.of<Clients>(context);

    if (clients.current == null) {
      return Container();
    }

    return Observer(
      builder: (_) => Theme(
        data: Theme.of(context).copyWith(canvasColor: fg(context)),
        child: Dropdown<Client>(
          color: Colors.transparent,
          value: clients.current,
          onChange: (dynamic selected) => selected.runtimeType == Client
              ? clients.setCurrent(selected)
              : clients.setCurrentIndex(selected),
          items: _buildClients(clients, _),
        ),
      ),
    );
  }

  List<DropdownMenuItem> _buildClients(Clients clients, BuildContext context) {
    return clients.clients
        .map((client) => DropdownMenuItem(
              child: Text(
                client.name,
                textAlign: TextAlign.center,
                style: textTheme(context).copyWith(
                  fontSize: 20,
                  color: isIos ? accent(context) : fgInverted(context),
                ),
              ),
              value: client,
              key: Key(client.name),
            ))
        .toList();
  }
}
