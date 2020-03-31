import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/widgets/dialog.dart';
import 'package:timesheet_flutter/widgets/platform/dialog.dart';

showClientDeleteDialog(BuildContext context) async {
  final Clients clients = Provider.of<Clients>(context, listen: false);

  final message = await showAlertDialog(
      context,
      DialogTitle(text: "Delete Client"),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text("all Timesheets of ${clients.current.name} will be lost!"),
      ),
      [
        CancelDialogButton(),
        ConfirmDialogButton(
          text: 'Delete',
          onTap: () async {
            final String name = clients.current.name;
            await clients.removeClient(clients.current);
            Navigator.of(context).pop("deleted $name!");
          },
        ),
      ]);

  showSuccess(context, message);
}
