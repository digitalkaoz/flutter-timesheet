import 'package:flutter/material.dart';
import 'package:timesheet_flutter/model/time.dart';
import 'package:timesheet_flutter/model/timesheet.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';
import 'package:timesheet_flutter/widgets/rows.dart';
import 'package:timesheet_flutter/widgets/timeheet_actions.dart';

class DismissibleTimesheet extends StatelessWidget {
  final Timesheet timesheet;
  final Function(Time) deleteCallback;
  final Function(Time) editCallback;

  const DismissibleTimesheet({
    Key key,
    this.timesheet,
    this.deleteCallback,
    this.editCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        HeaderRow(
          timesheet: timesheet,
        ),
        ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, int index) {
            return TimeRow(
              deleteCallback: deleteCallback,
              editCallback: editCallback,
              time: timesheet.times[index],
              timesheet: timesheet,
            );
          },
          itemCount: timesheet.times.length,
        ),
        TimesheetActions(
          timesheet: timesheet,
        ),
      ],
    );
  }
}

class HeaderRow extends StatelessWidget {
  final Timesheet timesheet;

  const HeaderRow({Key key, @required this.timesheet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      dataRowHeight: 0,
      columns: headerColumns(timesheet, true),
      rows: [],
      columnSpacing: 0,
    );
  }
}

class TimeRow extends StatelessWidget {
  final Time time;
  final Function(Time) deleteCallback;
  final Function(Time) editCallback;

  final Timesheet timesheet;

  const TimeRow({
    Key key,
    @required this.time,
    this.deleteCallback,
    this.editCallback,
    @required this.timesheet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey<Time>(time),
      confirmDismiss: (DismissDirection direction) async {
        if (direction == DismissDirection.endToStart) {
          //edit
          if (editCallback != null) {
            editCallback(time);
          }
          return false;
        }

        if (deleteCallback != null) {
          deleteCallback(time);
        }
        return false;
      },
      onDismissed: (DismissDirection direction) {
        if (deleteCallback != null) {
          deleteCallback(time);
        }
        if (isAndroid) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Deleted Time"),
          ));
        }
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      secondaryBackground: Container(
        color: Colors.green,
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
      ),
      child: DataTable(
        headingRowHeight: 0,
        columnSpacing: 0,
        columns: rowColumns(timesheet, time, true),
        rows: rowValues(context, time, timesheet,
            editCallback: editCallback,
            deleteCallback: deleteCallback,
            isSmall: true),
      ),
    );
  }
}
