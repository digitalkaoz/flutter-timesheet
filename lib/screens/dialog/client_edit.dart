import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/platform/dialog.dart';
import 'package:timesheet_flutter/widgets/platform/dialog_button.dart';
import 'package:timesheet_flutter/widgets/platform/input.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';

class ClientEditForm extends StatelessWidget {
  final TextEditingController _controller;

  const ClientEditForm(this._controller);

  @override
  Widget build(BuildContext context) {
    final Clients clients = Provider.of<Clients>(context);
    final Client client = clients.current;

    if (client == null) {
      return Container();
    }

    _controller.value = TextEditingValue(text: client.name);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Input(
        controller: _controller,
        textStyle: textThemeInverted(context),
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'Client Name',
        ),
      ),
    );
  }
}

showClientEditDialog(BuildContext context) async {
  final TextEditingController _controller = TextEditingController();
  final Clients clients = Provider.of<Clients>(context, listen: false);

  final message = await showAlertDialog(
      context,
      Text(
        "Edit ${clients.current.name}",
        textAlign: TextAlign.center,
        style: prettyTheme(context).copyWith(color: accent(context)),
      ),
      ClientEditForm(_controller),
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
              'Save',
              style: textTheme(context)
                  .copyWith(color: isIos ? accent(context) : null),
            ),
            onTap: () {
              final name = _controller.text;
              if (name.isNotEmpty) {
                clients.current.setName(name);
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
