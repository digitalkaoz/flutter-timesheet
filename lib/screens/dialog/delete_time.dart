import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:timesheet_flutter/model/time.dart';
import 'package:timesheet_flutter/model/timesheet.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/platform/dialog.dart';
import 'package:timesheet_flutter/widgets/platform/dialog_button.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';

class DeleteTime extends StatelessWidget {
  final Time time;
  final Timesheet timesheet;

  DeleteTime(this.time, this.timesheet);

  @override
  Widget build(BuildContext context) {
    return Text('${dateFormat(time.date)} - ${durationFormat(time.total)}');
  }
}

showTimeDeleteDialog(
    BuildContext context, Timesheet timesheet, Time time) async {
  final message = await showAlertDialog(
      context,
      Text(
        "Delete Time?",
        textAlign: TextAlign.center,
        style: prettyTheme(context).copyWith(color: accent(context)),
      ),
      DeleteTime(time, timesheet),
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
              'Yes',
              style: textTheme(context)
                  .copyWith(color: isIos ? accent(context) : null),
            ),
            onTap: () {
              timesheet.removeTime(time);
              Navigator.of(context).pop("deleted time!");
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
