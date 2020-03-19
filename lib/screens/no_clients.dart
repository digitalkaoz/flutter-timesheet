import 'package:flutter/material.dart' hide RaisedButton;
import 'package:timesheet_flutter/screens/dialog/client_add.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/logo.dart';
import 'package:timesheet_flutter/widgets/platform/button.dart';

class NoClientsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Logo(),
              Text(
                'Welcome!',
                style: prettyTheme(context)
                    .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                'Start by adding a Client. \n Then you can start tracking your times and generating reports.',
                textAlign: TextAlign.center,
                style: textTheme(context)
                    .copyWith(fontSize: 20, color: Colors.white),
              ),
              RaisedButton(
                child: Text(
                  "Add Client",
                  style: textTheme(context),
                ),
                tooltip: "Add another Client",
                onPressed: () => showClientAddDialog(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
