import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pdf/pdf.dart' show PdfPageFormat;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/time.dart';
import 'package:timesheet_flutter/model/timesheet.dart';
import 'package:timesheet_flutter/screens/dialog/delete_time.dart';
import 'package:timesheet_flutter/screens/dialog/finish_timesheet.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/report_pdf.dart';
import 'package:timesheet_flutter/widgets/rows.dart';

class TimesheetPanel {
  final Timesheet timesheet;
  final Client client;

  const TimesheetPanel({Key key, this.client, this.timesheet});

  ExpansionPanelRadio build(BuildContext context) {
    return ExpansionPanelRadio(
      value: timesheet,
      canTapOnHeader: true,
      headerBuilder: (BuildContext context, bool isExpanded) {
        return ListTile(
          title: Observer(builder: (_) => _builtHeader()),
        );
      },
      body: _buildBody(context, timesheet),
    );
  }

  Widget _builtHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text("${dateFormat(timesheet.start)} - ${dateFormat(timesheet.last)}",
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text(
          durationFormat(timesheet.total),
          style: TextStyle(fontWeight: FontWeight.w400, color: defaultColor),
        ),
      ],
    );
  }

  List<Widget> _buildButtons(BuildContext context) {
    final List<Widget> buttons = [
      FlatButton(
        child: Text("Export"),
        onPressed: () async {
          await Printing.layoutPdf(
              onLayout: (PdfPageFormat format) async =>
                  PdfReport(client, timesheet).build(format).save());
        },
      ),
    ];

    if (!timesheet.archived) {
      buttons.add(
        FlatButton(
          child: Text("Finish"),
          onPressed: () => showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) => FinishTimesheet(
              client: client,
              timesheet: timesheet,
            ),
          ),
        ),
      );
    }

    return buttons;
  }

  Widget _buildBody(BuildContext context, Timesheet timesheet) {
    if (timesheet.times.isEmpty) {
      return Container(
        padding: EdgeInsets.only(bottom: 20),
        child: Center(
          child: Text("no times added yet"),
        ),
      );
    }

    if (timesheet.archived || kIsWeb) {
      return Column(
        children: <Widget>[
          DataTable(
            columns: kIsWeb && timesheet.archived == false
                ? WEB_HEADER_COLUMNS
                : HEADER_COLUMNS,
            columnSpacing: 0,
            rows: timesheet.times
                .map((t) => TimeRow.buildRow(t,
                    archived: timesheet.archived,
                    deleteCallback: (time) => _deleteTime(time, context),
                    editCallback: (time) => _editTime(time, context)).first)
                .toList(),
          ),
          ButtonBar(
            children: _buildButtons(context),
          ),
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        HeaderRow(),
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (_, int index) {
            return TimeRow(
              deleteCallback: (time) => _deleteTime(time, context),
              editCallback: (time) => _editTime(time, context),
              time: timesheet.times[index],
            );
          },
          itemCount: timesheet.times.length,
        ),
        ButtonBar(
          children: _buildButtons(context),
        ),
      ],
    );
  }

  _deleteTime(Time time, BuildContext context) async {
    await showDialog(
      context: context,
      child: DeleteTime(
        time: time,
        timesheet: timesheet,
      ),
    );
  }

  _editTime(Time time, BuildContext context) {
    final PanelController sheet = Provider.of<PanelController>(context);
    client.currentTimesheet.setCurrentTime(time);
    sheet.open();
  }
}
