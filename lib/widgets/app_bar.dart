import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/client_chooser.dart';
import 'package:timesheet_flutter/widgets/device.dart';
import 'package:timesheet_flutter/widgets/drawer.dart';
import 'package:timesheet_flutter/widgets/platform/nav_bar.dart';

class NavBar extends StatelessWidget
    implements PreferredSizeWidget, ObstructingPreferredSizeWidget {
  Widget _chooser(BuildContext context, Clients clients) {
    return clients.current == null
        ? Container()
        : clients.clients.length == 1
            ? Container(
                width: 60,
                height: 60,
                child: Center(
                  child: Text(
                    clients.current.name,
                    style: TextStyle(color: accent(context)),
                  ),
                ),
              )
            : ClientChooser();
  }

  @override
  Widget build(BuildContext context) {
    final Clients clients = Provider.of<Clients>(context);

    return Observer(
      builder: (_) => PlatformNavBar(
        leading: clients.current == null ? Container() : null,
        drawer: ClientDrawer(),
        title: isTablet
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 80),
                  Text(
                    "Timesheets",
                    style: TextStyle(color: Colors.white),
                  ),
                  Expanded(child: SizedBox(width: 0)),
                  Container(
                      margin: EdgeInsets.only(right: 12),
                      color: Colors.grey[300],
                      child: _chooser(context, clients))
                ],
              )
            : clients.current == null
                ? Text(
                    "Timesheets",
                    style: TextStyle(color: Colors.white),
                  )
                : _chooser(context, clients),
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
