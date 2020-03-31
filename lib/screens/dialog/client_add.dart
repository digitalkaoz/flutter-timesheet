import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/model/persistence/local_storage.dart';
import 'package:timesheet_flutter/widgets/dialog.dart';
import 'package:timesheet_flutter/widgets/platform/dialog.dart';

showClientAddDialog(BuildContext context) async {
  final TextEditingController controller = TextEditingController();
  final Clients clients = Provider.of<Clients>(context, listen: false);
  final Storage storage = Provider.of<Storage>(context, listen: false);

  final message = await showAlertDialog(
      context,
      DialogTitle(text: "Add Client"),
      DialogInput(
        controller: controller,
        validator: (value) => clients.validateName(controller.text),
        placeholder: 'Client Name',
      ),
      [
        CancelDialogButton(),
        ConfirmDialogButton(
          text: 'Create',
          onTap: () async {
            final name = controller.text;
            if (name.isNotEmpty) {
              Client c = Client.generate(storage);
              c.setName(name);
              await clients.addClient(c);
              Navigator.of(context).pop();
            }
          },
        )
      ]);

  showSuccess(context, message);
}
