import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/time.dart';
import 'package:timesheet_flutter/model/timesheet.dart';
import 'package:timesheet_flutter/screens/dialog/delete_time.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/device.dart';
import 'package:timesheet_flutter/widgets/dismissible_timesheet.dart';
import 'package:timesheet_flutter/widgets/editable_timesheet.dart';

class TimesheetPanel {
  final Timesheet timesheet;
  final Client client;

  const TimesheetPanel({Key key, this.client, this.timesheet});

  ExpansionPanelRadio build(BuildContext context) {
    return ExpansionPanelRadio(
      value: timesheet,
      canTapOnHeader: true,
      headerBuilder: (BuildContext _, bool isExpanded) {
        return ListTile(
          title: Observer(builder: (_) => _builtHeader(context)),
        );
      },
      body: _buildBody(context, timesheet),
    );
  }

  Widget _builtHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "${dateFormat(timesheet.last)} - ${dateFormat(timesheet.start) == dateFormat(DateTime.now()) ? 'today' : dateFormat(timesheet.start)}",
          style: textThemeInverted(context),
        ),
        Text(
          durationFormat(timesheet.total),
          style:
              textThemeInverted(context).copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, Timesheet timesheet) {
    if (timesheet.times.isEmpty) {
      return Container(
        padding: EdgeInsets.only(bottom: 20),
        child: Center(
          child: Text(
            "no times added yet",
            style: prettyTheme(context)
                .copyWith(fontSize: 15, color: accent(context)),
          ),
        ),
      );
    }

    if (timesheet.archived || isWeb || isTablet) {
      return EditableTimsheet(
        timesheet: timesheet,
        deleteCallback: (time) =>
            showTimeDeleteDialog(context, timesheet, time),
        editCallback: (time) => _editTime(time, context),
      );
    }

    return DismissibleTimesheet(
      timesheet: timesheet,
      deleteCallback: (time) => showTimeDeleteDialog(context, timesheet, time),
      editCallback: (time) => _editTime(time, context),
    );
  }

  _editTime(Time time, BuildContext context) {
    client.currentTimesheet.setCurrentTime(time);
    try {
      final PanelController sheet =
          Provider.of<PanelController>(context, listen: false);
      sheet.open();
    } catch (e) {}
  }
}
