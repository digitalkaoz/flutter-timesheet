import 'package:flutter/material.dart';
import 'package:timesheet_flutter/screens/dialog/client_add.dart';
import 'package:timesheet_flutter/screens/dialog/client_delete.dart';
import 'package:timesheet_flutter/screens/dialog/client_edit.dart';

class MenuItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text("New Client"),
          leading: Icon(Icons.create_new_folder),
          onTap: () => _showDialog(context, ClientAddForm()),
        ),
        ListTile(
          title: Text("Edit"),
          leading: Icon(Icons.edit),
          onTap: () => _showDialog(context, ClientEditForm()),
        ),
        ListTile(
          title: Text("Delete"),
          leading: Icon(Icons.delete),
          onTap: () => _showDialog(context, ClientDelete()),
        ),
      ],
    );
  }

  void _showDialog(BuildContext context, Widget widget) async {
    var message = await showDialog(context: context, builder: (_) => widget);
    if (message != null) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }
  }
}
