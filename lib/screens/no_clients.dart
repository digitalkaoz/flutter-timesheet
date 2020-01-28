import 'package:flutter/material.dart';
import 'package:timesheet_flutter/screens/dialog/client_add.dart';

class NoClientsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Add a client to start!'),
            FloatingActionButton(
              elevation: 0,
              child: Icon(Icons.add),
              tooltip: "Add another Client",
              onPressed: () => showClientAddDialog(context),
            )
          ],
        ),
      ),
    );
  }
}
