import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/model/persistence/local_storage.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/platform/dialog.dart';
import 'package:timesheet_flutter/widgets/platform/dialog_button.dart';
import 'package:timesheet_flutter/widgets/platform/input.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';

class ClientAddForm extends StatelessWidget {
  final TextEditingController _controller;

  ClientAddForm(this._controller);

  @override
  Widget build(BuildContext context) {
    final Clients clients = Provider.of<Clients>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Input(
        controller: _controller,
        textStyle: textThemeInverted(context),
        autofocus: true,
        validator: (value) => clients.validateName(_controller.text),
      ),
    );
  }
}

showClientAddDialog(BuildContext context) async {
  final TextEditingController _controller = TextEditingController();
  final Clients clients = Provider.of<Clients>(context, listen: false);
  final Storage storage = Provider.of<Storage>(context, listen: false);

  final message = await showAlertDialog(
      context,
      Text(
        "Add Client",
        textAlign: TextAlign.center,
        style: prettyTheme(context).copyWith(color: accent(context)),
      ),
      ClientAddForm(_controller),
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
              'Create',
              style: textTheme(context)
                  .copyWith(color: isIos ? accent(context) : null),
            ),
            onTap: () {
              final name = _controller.text;
              if (name.isNotEmpty) {
                Client c = Client.generate(storage);
                c.setName(name);
                clients.addClient(c);
                Navigator.of(context).pop();
              }
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
