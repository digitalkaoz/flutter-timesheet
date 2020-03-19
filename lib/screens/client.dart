import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/timesheet.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';
import 'package:timesheet_flutter/widgets/timesheet_panel.dart';

class ClientOverview extends StatelessWidget {
  final Client client;

  ClientOverview(this.client);

  List<ExpansionPanelRadio> _buildPanels(BuildContext context) {
    return client.timesheets
        .map(
          (Timesheet timesheet) => TimesheetPanel(
            client: client,
            timesheet: timesheet,
          ).build(context),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 158, top: kToolbarHeight + 30),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Observer(
        builder: (_) => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: !client.hasTimesheets
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              !client.hasTimesheets
                  ? Container(
                      child: Center(
                          child: Text(
                        "start saving times",
                        style: prettyTheme(context),
                      )),
                    )
                  : Theme(
                      data: Theme.of(context).copyWith(
                          cardColor:
                              isIos && brightness(context) == Brightness.dark
                                  ? Colors.grey[800]
                                  : null),
                      child: ExpansionPanelList.radio(
                        initialOpenPanelValue: client.currentTimesheet,
                        key: Key('${client.name}-timesheets'),
                        children: _buildPanels(context),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
