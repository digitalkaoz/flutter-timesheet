import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/timesheet.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';
import 'package:timesheet_flutter/widgets/timesheet_panel.dart';

class ClientOverview extends StatefulWidget {
  final Client client;
  final bool secondary;
  final bool noBottomSheet;

  ClientOverview(this.client,
      {this.secondary = false, this.noBottomSheet = false});

  @override
  _ClientOverviewState createState() => _ClientOverviewState();
}

class _ClientOverviewState extends State<ClientOverview> {
  List<Timesheet> _previousList;
  Key key;
  List<ExpansionPanelRadio> _buildPanels(BuildContext context) {
    return widget.client.timesheets
        .where((t) => t != null)
        .map(
          (Timesheet timesheet) => TimesheetPanel(
            client: widget.client,
            timesheet: timesheet,
          ).build(context),
        )
        .toList();
  }

  @override
  initState() {
    super.initState();
    if (widget.client.hasTimesheets) {
      _previousList = List.of(widget.client.timesheets);
      key = Key("${widget.client.name}-${_previousList.length}");
    }
  }

  Widget _content(BuildContext context) {
    if (widget.client.hasTimesheets &&
        _previousList.length != widget.client.timesheets.length) {
      key = Key("${widget.client.name}-${++widget.client.timesheets.length}");
      _previousList = List.of(widget.client.timesheets);
    }
    return Observer(
      builder: (_) => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: !widget.client.hasTimesheets
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            !widget.client.hasTimesheets
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
                      initialOpenPanelValue: widget.client.currentTimesheet,
                      key: key,
                      children: _buildPanels(context),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.secondary) {
      return _content(context);
    }

    return Container(
      margin: EdgeInsets.only(
          bottom: widget.noBottomSheet ? 0 : 70,
          top: widget.noBottomSheet ? kToolbarHeight : kToolbarHeight + 30),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: _content(context),
    );
  }
}
