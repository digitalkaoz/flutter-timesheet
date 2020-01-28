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
          onTap: () async {
            await showClientAddDialog(context);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text("Edit"),
          leading: Icon(Icons.edit),
          onTap: () async {
            await showClientEditDialog(context);
            Navigator.pop(context);
          },
        ),
        ListTile(
            title: Text("Delete"),
            leading: Icon(Icons.delete),
            onTap: () async {
              await showClientDeleteDialog(context);
              Navigator.pop(context);
            }),
      ],
    );
  }
}
