import 'package:flutter/material.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/timesheet.dart';

class FinishTimesheet extends StatelessWidget {
  final Client client;
  final Timesheet timesheet;

  const FinishTimesheet({Key key, this.client, this.timesheet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Finish Timesheet'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Really finish Timesheet and start a new one?'),
            Text('You wont be able to add times to it!'),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text('Yes'),
          onPressed: () {
            client.finishSheet(timesheet);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
