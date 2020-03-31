import 'package:flutter/material.dart';
import 'package:timesheet_flutter/model/time.dart';
import 'package:timesheet_flutter/model/timesheet.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/dialog.dart';
import 'package:timesheet_flutter/widgets/platform/dialog.dart';

showTimeDeleteDialog(
    BuildContext context, Timesheet timesheet, Time time) async {
  final message = await showAlertDialog(
      context,
      DialogTitle(text: "Delete Time"),
      Text(
        '${dateFormat(time.date)} - ${durationFormat(time.total)}',
      ),
      [
        CancelDialogButton(),
        ConfirmDialogButton(
          text: 'Yes',
          onTap: () async {
            await timesheet.removeTime(time);
            Navigator.of(context).pop("deleted time!");
          },
        ),
      ]);
  showSuccess(context, message);
}
