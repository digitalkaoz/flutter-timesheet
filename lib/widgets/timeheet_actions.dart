import 'package:flutter/material.dart' hide Icon;
import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart' show PdfPageFormat;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/model/timesheet.dart';
import 'package:timesheet_flutter/screens/dialog/finish_timesheet.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/platform/button.dart';
import 'package:timesheet_flutter/widgets/platform/icon.dart';
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
      alignment: MainAxisAlignment.spaceBetween,
      children: _buildButtons(context),
    );
  }

  List<Widget> _buildButtons(BuildContext context) {
    final Client client = Provider.of<Clients>(context).current;
    final buttonTheme =
        prettyTheme(context).copyWith(color: accent(context), fontSize: 16);

    final List<Widget> buttons = [
      Button(
        child: Row(
          children: <Widget>[
            PlatformIcon(
              icon: Icon(
                Icons.cloud_download,
                color: accent(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Export",
                style: buttonTheme,
              ),
            ),
          ],
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
            child: Row(
              children: <Widget>[
                PlatformIcon(
                  icon: Icon(
                    Icons.check,
                    color: accent(context),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Finish",
                    style: buttonTheme,
                  ),
                ),
              ],
            ),
            onPressed: () async {
              await showFinishTimesheetDialog(context, client, timesheet);
            }),
      );
    }

    return buttons;
  }
}
