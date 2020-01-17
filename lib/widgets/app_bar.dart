import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/widgets/client_chooser.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    final Clients clients = Provider.of<Clients>(context);

    return Observer(
      builder: (_) {
        if (clients.current == null) {
          return AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text("Timesheets"),
          );
        }

        return AppBar(
          centerTitle: true,
          title: ClientChooser(),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
