import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/widgets/dialog.dart';
import 'package:timesheet_flutter/widgets/platform/dialog.dart';

showClientEditDialog(BuildContext context) async {
  final TextEditingController controller = TextEditingController();
  final Clients clients = Provider.of<Clients>(context, listen: false);

  controller.value = TextEditingValue(text: clients.current.name);

  final message = await showAlertDialog(
      context,
      DialogTitle(text: "Edit ${clients.current.name}"),
      DialogInput(
        controller: controller,
        placeholder: 'Client Name',
        validator: (value) => clients.validateName(controller.text),
      ),
      [
        CancelDialogButton(),
        ConfirmDialogButton(
          text: 'Save',
          onTap: () async {
            final name = controller.text;
            if (name.isNotEmpty) {
              await clients.current.setName(name);
              Navigator.of(context).pop();
            }
          },
        ),
      ]);

  showSuccess(context, message);
}
