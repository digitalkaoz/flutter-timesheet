import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/clients.dart';

class ClientDelete extends StatelessWidget {
  Widget build(BuildContext context) {
    final Clients clients = Provider.of<Clients>(context);

    return AlertDialog(
      title: Text('Delete Client'),
      content: Text("all Timesheets of ${clients.current.name} will be lost!"),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text('Delete'),
          onPressed: () {
            final String name = clients.current.name;
            clients.removeClient(clients.current);
            Navigator.of(context).pop("deleted $name!");
          },
        ),
      ],
    );
  }
}
