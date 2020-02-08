import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:timesheet_flutter/model/time.dart';
import 'package:timesheet_flutter/model/timesheet.dart';
import 'package:timesheet_flutter/services/theme.dart';

const List<DataColumn> HEADER_COLUMNS = [
  DataColumn(
    label: Text('Date'),
  ),
  DataColumn(
    label: Text('From'),
    numeric: true,
  ),
  DataColumn(
    label: Text('Pause'),
    numeric: true,
  ),
  DataColumn(
    label: Text('End'),
    numeric: true,
  ),
  DataColumn(
    label: Text(
      'Total',
      style: TextStyle(fontWeight: FontWeight.w900),
    ),
    numeric: true,
  ),
];

List<DataColumn> headerColumns(Timesheet timesheet, bool isSmall) {
  var columns = HEADER_COLUMNS;

  if (!isSmall) {
    columns.insert(
      1,
      DataColumn(
        label: Text('Description'),
      ),
    );
  }

  if (kIsWeb && !timesheet.archived) {
    columns.add(
      DataColumn(
        label: Text('Actions'),
        numeric: true,
      ),
    );
  }

  return columns;
}

const List<DataColumn> ROW_COLUMNS = [
  DataColumn(
    label: Text(
      'Date',
      style: TextStyle(color: Colors.transparent),
    ),
  ),
  DataColumn(
    label: Text(
      'From',
      style: TextStyle(color: Colors.transparent),
    ),
    numeric: true,
  ),
  DataColumn(
    label: Text(
      'Pause',
      style: TextStyle(color: Colors.transparent),
    ),
    numeric: true,
  ),
  DataColumn(
    label: Text(
      'End',
      style: TextStyle(color: Colors.transparent),
    ),
    numeric: true,
  ),
  DataColumn(
    label: Text(
      'Total',
      style: TextStyle(color: Colors.transparent),
    ),
    numeric: true,
  ),
];

List<DataColumn> rowColumns(Timesheet timesheet, Time time, bool isSmall) {
  var columns = ROW_COLUMNS;

  if (!isSmall) {
    columns.insert(
      1,
      DataColumn(
        label: Text(time.description),
      ),
    );
  }

  if (kIsWeb && !timesheet.archived) {
    columns.add(
      DataColumn(
        label: Text('Actions'),
        numeric: true,
      ),
    );
  }

  return columns;
}

List<DataRow> rowValues(BuildContext context, Time time, Timesheet timesheet,
    {Function(Time) deleteCallback,
    Function(Time) editCallback,
    bool isSmall}) {
  var cells = [
    DataCell(
      Text(
        dateFormat(
          time.date,
        ),
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
    DataCell(
      Text(timeFormat(time.start)),
    ),
    DataCell(
      Text(durationFormat(time.pause)),
    ),
    DataCell(
      Text(timeFormat(time.end)),
    ),
    DataCell(
      Text(
        durationFormat(time.total),
        style: TextStyle(
            color: (Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Theme.of(context).primaryColorDark),
            fontWeight: FontWeight.bold),
      ),
    )
  ];

  if (!isSmall) {
    cells.insert(
      1,
      DataCell(
        Text(time.description),
      ),
    );
  }

  if (kIsWeb && !timesheet.archived) {
    cells.add(
      DataCell(
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => editCallback(time),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => deleteCallback(time),
              ),
            ],
          ),
        ),
      ),
    );
  }

  return [
    DataRow(
      cells: cells,
    )
  ];
}
