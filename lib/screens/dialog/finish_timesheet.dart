import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/timesheet.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/platform/dialog.dart';
import 'package:timesheet_flutter/widgets/platform/dialog_button.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';

class FinishTimesheet extends StatelessWidget {
  final Client client;
  final Timesheet timesheet;

  const FinishTimesheet({Key key, this.client, this.timesheet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListBody(
      children: <Widget>[
        Text('Really finish Timesheet and start a new one?'),
        Text('You wont be able to add times to it!'),
      ],
    );
  }
}

showFinishTimesheetDialog(
    BuildContext context, Client client, Timesheet timesheet) async {
  final message = await showAlertDialog(
      context,
      Text(
        'Finish Timesheet',
        textAlign: TextAlign.center,
        style: prettyTheme(context).copyWith(color: accent(context)),
      ),
      FinishTimesheet(
        client: client,
        timesheet: timesheet,
      ),
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
            client.finishSheet(timesheet);
            Navigator.of(context).pop("finished timesheet");
          },
        ),
      ]);
  if (message != null) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
  }
}
