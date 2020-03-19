import 'package:flutter/material.dart' hide RaisedButton;
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/screens/dialog/client_add.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/logo.dart';
import 'package:timesheet_flutter/widgets/menu_items.dart';
import 'package:timesheet_flutter/widgets/platform/button.dart';

class ClientDrawer extends StatelessWidget {
  final Widget child;

  const ClientDrawer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Clients clients = Provider.of<Clients>(context);
    if (clients.current == null) {
      return Container();
    }

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: bg(context)),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Logo(
                      size: 30,
                    ),
                    RaisedButton(
                      child: Text(
                        "Add Client",
                        style: textTheme(context),
                      ),
                      tooltip: "Add another Client",
                      onPressed: () async {
                        await showClientAddDialog(context);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
            MenuItems(),
            child != null ? child : Container()
          ],
        ),
      ),
    );
  }
}
