import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart' show PdfPageFormat;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/model/timesheet.dart';
import 'package:timesheet_flutter/screens/dialog/finish_timesheet.dart';
import 'package:timesheet_flutter/widgets/platform/button.dart';
import 'package:timesheet_flutter/widgets/report_pdf.dart';

class TimesheetActions extends StatelessWidget {
  final Timesheet timesheet;

  const TimesheetActions({
    Key key,
    this.timesheet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      children: _buildButtons(context),
    );
  }

  List<Widget> _buildButtons(BuildContext context) {
    final Client client = Provider.of<Clients>(context).current;

    final List<Widget> buttons = [
      Button(
        child: Text(
          "Export",
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        onPressed: () async {
          await Printing.layoutPdf(
              onLayout: (PdfPageFormat format) async =>
                  PdfReport(client, timesheet).build(format).save());
        },
      ),
    ];

    if (!timesheet.archived) {
      buttons.add(
        Button(
          child: Text(
            "Finish",
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
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
}
