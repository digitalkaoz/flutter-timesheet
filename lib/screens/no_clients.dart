import 'package:flutter/material.dart';
import 'package:timesheet_flutter/screens/dialog/client_add.dart';

class NoClientsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('you dont have any clients yet, try to add one'),
            FloatingActionButton(
              child: Icon(Icons.add),
              tooltip: "Add another Client",
              onPressed: () => _showDialog(context),
            )
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) async {
    final message = await showDialog<String>(
        context: context, builder: (_) => ClientAddForm());
    if (message != null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
  }
}
