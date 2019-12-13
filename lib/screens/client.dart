import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/timesheet.dart';
import 'package:timesheet_flutter/widgets/timesheet_panel.dart';

class ClientOverview extends StatelessWidget {
  final Client client;

  ClientOverview(this.client);

  List<ExpansionPanelRadio> _buildPanels(BuildContext context) {
    return client.timesheets
        .map(
          (Timesheet timesheet) =>
              TimesheetPanel(client: client, timesheet: timesheet)
                  .build(context),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(bottom: 62),
        child: Observer(
          builder: (_) => Column(
            mainAxisAlignment: !client.hasTimesheets
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: <Widget>[
              !client.hasTimesheets
                  ? Container(
                      child: Center(child: Text("start saving times")),
                    )
                  : ExpansionPanelList.radio(
                      initialOpenPanelValue: client.currentTimesheet,
                      key: Key('${client.name}-timesheets'),
                      children: _buildPanels(context),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
