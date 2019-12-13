import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/screens/dialog/client_add.dart';
import 'package:timesheet_flutter/screens/dialog/client_delete.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    final Clients clients = Provider.of<Clients>(context);

    return Observer(
      builder: (_) => AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: clients.current != null
            ? IconButton(
                icon: Icon(Icons.add),
                tooltip: 'Add another Client',
                onPressed: () => _showDialog(_, ClientAddForm()),
              )
            : Container(),
        title: Text(clients.currentTitle),
        actions: <Widget>[
          clients.current != null
              ? IconButton(
                  icon: Icon(Icons.delete_forever),
                  tooltip: 'Delete Client',
                  onPressed: () => _showDialog(_, ClientDelete()),
                )
              : Container(),
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

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
