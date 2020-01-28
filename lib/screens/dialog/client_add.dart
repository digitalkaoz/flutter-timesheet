import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/model/persistence/local_storage.dart';
import 'package:timesheet_flutter/model/timesheet.dart';
import 'package:timesheet_flutter/widgets/platform/dialog.dart';
import 'package:timesheet_flutter/widgets/platform/dialog_button.dart';
import 'package:timesheet_flutter/widgets/platform/input.dart';

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
        autofocus: true,
        validator: (value) => clients.validateName(_controller.text),
        decoration: InputDecoration(
          hintText: 'Client Name',
        ),
      ),
    );
  }
}

showClientAddDialog(BuildContext context) async {
  final TextEditingController _controller = TextEditingController();
  final Clients clients = Provider.of<Clients>(context, listen: false);
  final Storage storage = Provider.of<Storage>(context, listen: false);

  final message = await showAlertDialog(
      context, Text("Add Client"), ClientAddForm(_controller), [
    DialogButton(
      child: Text('Cancel'),
      onTap: () => Navigator.of(context).pop(),
    ),
    DialogButton(
        primary: true,
        child: Text('Create'),
        onTap: () {
          final name = _controller.text;
          if (name.isNotEmpty) {
            Client c = Client.generate(storage);
            clients.addClient(c);
            c.setName(name);
            c.addSheet(Timesheet.generate(storage));
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
