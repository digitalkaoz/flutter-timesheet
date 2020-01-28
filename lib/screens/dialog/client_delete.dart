import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/widgets/platform/dialog.dart';
import 'package:timesheet_flutter/widgets/platform/dialog_button.dart';

class ClientDelete extends StatelessWidget {
  final String name;

  const ClientDelete({Key key, this.name}) : super(key: key);

  Widget build(BuildContext context) {
    return Text("all Timesheets of $name will be lost!");
  }
}

showClientDeleteDialog(BuildContext context) async {
  final Clients clients = Provider.of<Clients>(context, listen: false);

  final message = await showAlertDialog(context, Text("Delete Client"),
      ClientDelete(name: clients.current.name), [
    DialogButton(
      child: Text('Cancel'),
      onTap: () => Navigator.of(context).pop(),
    ),
    DialogButton(
        primary: true,
        child: Text('Delete'),
        onTap: () {
          final String name = clients.current.name;
          clients.removeClient(clients.current);
          Navigator.of(context).pop("deleted $name!");
        }),
  ]);
  if (message != null) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
  }
}
