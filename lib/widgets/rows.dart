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

class HeaderRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: HEADER_COLUMNS,
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
        print("delete");
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
            columns: ROW_COLUMNS,
            rows: buildRow(time),
          )
        ],
      ),
    );
  }

  static List<DataRow> buildRow(Time time) {
    return [
      DataRow(cells: [
        DataCell(Text(
            dateFormat(
              time.date,
            ),
            style: TextStyle(fontWeight: FontWeight.w600))),
        DataCell(
          Text('${time.start.hour}:${time.start.minute}'),
        ),
        DataCell(
          Text(durationFormat(time.pause)),
        ),
        DataCell(
          Text('${time.end.hour}:${time.end.minute}'),
        ),
        DataCell(Text(
          durationFormat(time.total),
          style: TextStyle(color: defaultColor, fontWeight: FontWeight.bold),
        ))
      ])
    ];
  }
}
