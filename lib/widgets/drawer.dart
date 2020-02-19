import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/menu_items.dart';

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
                child: Text(
                  "Timesheets",
                  style: Theme.of(context)
                      .textTheme
                      .headline
                      .copyWith(color: Colors.white),
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
