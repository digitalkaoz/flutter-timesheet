import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/services/theme.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    final Clients clients = Provider.of<Clients>(context);

    if (clients.current == null) {
      return AppBar(
        title: Text("Timesheets"),
      );
    }

    return Observer(
      builder: (_) => AppBar(
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Client>(
              iconSize: 30,
              isDense: true,
              iconEnabledColor: defaultColor,
              value: clients.current,
              onChanged: (Client selected) => clients.setCurrent(selected),
              items: _buildClients(clients),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  List<DropdownMenuItem> _buildClients(Clients clients) {
    return clients.clients
        .map((client) => DropdownMenuItem(
              child: Text(
                client.name,
                style: TextStyle(color: defaultColor),
              ),
              value: client,
              key: Key(client.name),
            ))
        .toList();
  }
}
