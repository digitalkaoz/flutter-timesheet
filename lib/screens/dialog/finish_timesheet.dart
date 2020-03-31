import 'package:flutter/material.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/timesheet.dart';
import 'package:timesheet_flutter/widgets/dialog.dart';
import 'package:timesheet_flutter/widgets/platform/dialog.dart';

showFinishTimesheetDialog(
    BuildContext context, Client client, Timesheet timesheet) async {
  final message = await showAlertDialog(
      context,
      DialogTitle(text: 'Finish Timesheet'),
      ListBody(
        children: <Widget>[
          Text('Really finish Timesheet and start a new one?'),
          Text('You wont be able to add times to it!'),
        ],
      ),
      [
        CancelDialogButton(),
        ConfirmDialogButton(
          text: 'Yes',
          onTap: () async {
            await client.finishSheet(timesheet);
            Navigator.of(context).pop("finished timesheet");
          },
        ),
      ]);
  showSuccess(context, message);
}
