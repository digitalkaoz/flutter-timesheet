import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/screens/dialog/client_add.dart';
import 'package:timesheet_flutter/screens/dialog/client_delete.dart';
import 'package:timesheet_flutter/screens/dialog/client_edit.dart';
import 'package:timesheet_flutter/services/theme.dart';

class ClientDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Clients clients = Provider.of<Clients>(context);
    if (clients.current == null) {
      return Container();
    }

    final client = clients.current;

    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                client.name,
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .copyWith(color: defaultColor),
              ),
            ),
          ),
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
          )
        ],
      ),
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
