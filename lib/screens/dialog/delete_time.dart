import 'package:flutter/material.dart';
import 'package:timesheet_flutter/model/time.dart';
import 'package:timesheet_flutter/model/timesheet.dart';

class DeleteTime extends StatelessWidget {
  final Timesheet timesheet;
  final Time time;

  const DeleteTime({Key key, this.timesheet, this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Time'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Really delete this Time?'),
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
            timesheet.times.remove(time);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
