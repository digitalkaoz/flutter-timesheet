import 'package:flutter/material.dart';
import 'package:timesheet_flutter/widgets/client_chooser.dart';
import 'package:timesheet_flutter/widgets/menu_items.dart';
import 'package:timesheet_flutter/widgets/time_add_form.dart';

class ExpandedDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.only(top: 8),
            margin: EdgeInsets.all(0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Timesheet",
                    style: Theme.of(context).textTheme.headline,
                  ),
                  ClientChooser(),
                ],
              ),
            ),
          ),
          MenuItems(),
          TimeAddForm(dense: true),
        ],
      ),
    );
  }
}
