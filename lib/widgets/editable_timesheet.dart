import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:timesheet_flutter/model/time.dart';
import 'package:timesheet_flutter/model/timesheet.dart';
import 'package:timesheet_flutter/widgets/rows.dart';
import 'package:timesheet_flutter/widgets/timeheet_actions.dart';

class EditableTimsheet extends StatelessWidget {
  final Timesheet timesheet;
  final Function(Time) deleteCallback;
  final Function(Time) editCallback;

  const EditableTimsheet({
    Key key,
    this.timesheet,
    this.deleteCallback,
    this.editCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        LayoutBuilder(
          builder: (_, constraints) {
            return DataTable(
              columns: headerColumns(timesheet, constraints.maxWidth < 600),
              columnSpacing: 0,
              rows: timesheet.times
                  .map((t) => rowValues(
                        context,
                        t,
                        timesheet,
                        deleteCallback: deleteCallback,
                        editCallback: editCallback,
                        isSmall: constraints.maxWidth < 600,
                      ).first)
                  .toList(),
            );
          },
        ),
        TimesheetActions(timesheet: timesheet),
      ],
    );
  }
}
