import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/platform/dialog.dart';
import 'package:timesheet_flutter/widgets/platform/dialog_button.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';

class ClientDelete extends StatelessWidget {
  final String name;

  const ClientDelete({Key key, this.name}) : super(key: key);

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        "all Timesheets of $name will be lost!",
        style: textThemeInverted(context),
      ),
    );
  }
}

showClientDeleteDialog(BuildContext context) async {
  final Clients clients = Provider.of<Clients>(context, listen: false);

  final message = await showAlertDialog(
      context,
      Text(
        "Delete Client",
        textAlign: TextAlign.center,
        style: prettyTheme(context).copyWith(color: accent(context)),
      ),
      ClientDelete(name: clients.current.name),
      [
        DialogButton(
          color: fg(context),
          child: Text(
            'Cancel',
            style: textTheme(context)
                .copyWith(color: isIos ? accent(context) : fg(context)),
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
        DialogButton(
            primary: true,
            color: accent(context),
            child: Text(
              'Delete',
              style: textTheme(context)
                  .copyWith(color: isIos ? accent(context) : null),
            ),
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
