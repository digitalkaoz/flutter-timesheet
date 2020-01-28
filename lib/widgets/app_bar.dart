import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/widgets/client_chooser.dart';
import 'package:timesheet_flutter/widgets/drawer.dart';
import 'package:timesheet_flutter/widgets/platform/nav_bar.dart';

class NavBar extends StatelessWidget
    implements PreferredSizeWidget, ObstructingPreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    final Clients clients = Provider.of<Clients>(context);

    return Observer(
      builder: (_) => PlatformNavBar(
        leading: clients.current == null ? Container() : null,
        drawer: ClientDrawer(),
        title: clients.current == null
            ? Text(
                "Timesheets",
                style: TextStyle(color: Colors.white),
              )
            : clients.clients.length == 1
                ? Text(
                    clients.current.name,
                    style: TextStyle(color: Colors.white),
                  )
                : ClientChooser(),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return true;
  }
}
