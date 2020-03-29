import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide FlatButton, IconButton;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/screens/dialog/client_delete.dart';
import 'package:timesheet_flutter/screens/dialog/client_edit.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/client_chooser.dart';
import 'package:timesheet_flutter/widgets/device.dart';
import 'package:timesheet_flutter/widgets/drawer.dart';
import 'package:timesheet_flutter/widgets/platform/button.dart';
import 'package:timesheet_flutter/widgets/platform/nav_bar.dart';

class NavBar extends StatelessWidget
    implements PreferredSizeWidget, ObstructingPreferredSizeWidget {
  Widget _chooser(BuildContext context, Clients clients) {
    return clients.current == null
        ? Container()
        : clients.clients.length == 1
            ? Container(
                width: MediaQuery.of(context).size.width - 80,
                height: 60,
                child: Center(
                  child: Text(
                    clients.current.name,
                    style: textTheme(context)
                        .copyWith(fontSize: 20, color: fgInverted(context)),
                  ),
                ),
              )
            : Container(
                width: MediaQuery.of(context).size.width - 80,
                child: ClientChooser());
  }

  @override
  Widget build(BuildContext context) {
    final Clients clients = Provider.of<Clients>(context);

    return Observer(
      builder: (_) => PlatformNavBar(
        leading: clients.current == null ? Container() : null,
        trailing: clients.current == null
            ? Container()
            : MenuButton(
                icon: Icons.more_vert,
                color: Colors.white,
                items: _menuItems(_),
              ),
        drawer: ClientDrawer(),
        title: isTablet
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 40),
                  clients.current == null
                      ? Container()
                      : Text(
                          "Timesheets",
                          style: logoTheme(_).copyWith(fontSize: 24),
                        ),
                  SizedBox(width: 40),
                  Flexible(
                    child: Container(
                        margin: EdgeInsets.only(right: 12),
                        child: _chooser(context, clients)),
                  )
                ],
              )
            : clients.current == null
                ? Container()
                : _chooser(context, clients),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return false;
  }

  List<Map<String, dynamic>> _menuItems(BuildContext context) {
    return [
      {
        "child": Text(
          "Edit",
          style: textThemeInverted(context),
        ),
        "action": () async {
          await showClientEditDialog(context);
          Navigator.pop(context);
        }
      },
      {
        "child": Text(
          "Delete",
          style: textThemeInverted(context).copyWith(color: accent(context)),
        ),
        "action": () async {
          await showClientDeleteDialog(context);
          Navigator.pop(context);
        }
      }
    ];
  }
}
