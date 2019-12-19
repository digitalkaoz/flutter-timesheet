import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:timesheet_flutter/model/time.dart';
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

const List<DataColumn> WEB_HEADER_COLUMNS = [
  ...HEADER_COLUMNS,
  DataColumn(
    label: Text('Actions'),
  )
];

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

const List<DataColumn> WEB_ROW_COLUMNS = [
  ...ROW_COLUMNS,
  DataColumn(
    label: Text('Actions'),
  )
];

class HeaderRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: kIsWeb ? WEB_HEADER_COLUMNS : HEADER_COLUMNS,
      rows: [],
      columnSpacing: 0,
    );
  }
}

class TimeRow extends StatelessWidget {
  final Time time;
  final Function(Time) deleteCallback;
  final Function(Time) editCallback;

  const TimeRow({
    Key key,
    this.time,
    this.deleteCallback,
    this.editCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey<Time>(time),
      confirmDismiss: (DismissDirection direction) async {
        if (direction == DismissDirection.endToStart) {
          if (editCallback != null) {
            editCallback(time);
          }
          return false;
        }
        return true;
      },
      onDismissed: (DismissDirection direction) {
        if (deleteCallback != null) {
          deleteCallback(time);
        }
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Deleted Time"),
        ));
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
      child: Column(
        children: <Widget>[
          //Text(time.description ?? ""),
          DataTable(
            headingRowHeight: 0,
            columnSpacing: 0,
            columns: kIsWeb ? WEB_ROW_COLUMNS : ROW_COLUMNS,
            rows: buildRow(time),
          )
        ],
      ),
    );
  }

  static List<DataRow> buildRow(Time time,
      {bool archived: false,
      Function(Time) deleteCallback,
      Function(Time) editCallback}) {
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
          style: TextStyle(color: defaultColor, fontWeight: FontWeight.bold),
        ),
      )
    ];

    if (kIsWeb && archived == false) {
      cells.add(DataCell(Container(
        child: Row(
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
      )));
    }

    return [
      DataRow(
        cells: cells,
      )
    ];
  }
}
