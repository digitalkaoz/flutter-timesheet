import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/time.dart';
import 'package:timesheet_flutter/model/timesheet.dart';
import 'package:timesheet_flutter/services/theme.dart';

class PdfReport {
  final Client client;
  final Timesheet timesheet;
  PdfReport(this.client, this.timesheet);

  Document build(PdfPageFormat format) {
    final pdf = Document();

    pdf.addPage(
      Page(
        pageTheme: myPageTheme(format),
        build: (Context context) => Column(
          children: <Widget>[
            Header(text: "Timesheet - ${client.name}"),
            SizedBox(height: 20),
            Text(
              "${dateFormat(timesheet.last)} - ${dateFormat(timesheet.start)}",
            ),
            SizedBox(height: 40),
            Expanded(
              fit: FlexFit.loose,
              child: Table(
                children: _buildRows(),
              ),
            )
          ],
        ),
      ),
    ); // Page

    return pdf;
  }

  _buildRows() {
    List<TableRow> rows = [];

    rows.add(
      TableRow(
        children: ['Date', 'Description', 'Start', 'Pause', 'End', 'Total']
            .map(
              (header) => _cell(
                header,
                color: green,
                alignment: Alignment.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
            .toList(),
      ),
    );

    timesheet.times.reversed.forEach(
      (Time time) => rows.add(
        TableRow(children: [
          _cell(dateFormat(time.date)),
          _cell(time.description ?? ""),
          _cell(timeFormat(time.start)),
          _cell(durationFormat(time.pause)),
          _cell(timeFormat(time.end)),
          _cell(durationFormat(time.total)),
        ]),
      ),
    );

    rows.add(TableRow(children: [Text("")]));
    rows.add(
      TableRow(
        children: [
          Text(""),
          Text(""),
          Text(""),
          Text(""),
          Text(""),
          _cell(
            durationFormat(timesheet.total),
            alignment: Alignment.centerRight,
            color: green,
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );

    return rows;
  }

  Widget _cell(String content,
      {PdfColor color: white,
      Alignment alignment: Alignment.centerRight,
      TextStyle style}) {
    return Container(
      color: color,
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.symmetric(vertical: 2),
      alignment: alignment,
      child: Text(
        content,
        style: style != null
            ? style.copyWith(
                color: black,
              )
            : TextStyle(
                color: black,
              ),
      ),
    );
  }
}

const PdfColor green = PdfColor.fromInt(0xff9ce5d0);
const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);
const PdfColor lightGrey = PdfColor.fromInt(0xaa000000);
const PdfColor black = PdfColor.fromInt(0x00000000);
const PdfColor white = PdfColor.fromInt(0xffffffff);

PageTheme myPageTheme(PdfPageFormat format) {
  return PageTheme(
    pageFormat: format.applyMargin(
        left: 2.0 * PdfPageFormat.cm,
        top: 4.0 * PdfPageFormat.cm,
        right: 2.0 * PdfPageFormat.cm,
        bottom: 2.0 * PdfPageFormat.cm),
    buildBackground: (Context context) {
      return FullPage(
        ignoreMargins: true,
        child: CustomPaint(
          size: PdfPoint(format.width, format.height),
          painter: (PdfGraphics canvas, PdfPoint size) {
            context.canvas
              ..setColor(lightGreen)
              ..moveTo(0, size.y)
              ..lineTo(0, size.y - 230)
              ..lineTo(60, size.y)
              ..fillPath()
              ..setColor(green)
              ..moveTo(0, size.y)
              ..lineTo(0, size.y - 100)
              ..lineTo(100, size.y)
              ..fillPath()
              ..setColor(lightGreen)
              ..moveTo(30, size.y)
              ..lineTo(110, size.y - 50)
              ..lineTo(150, size.y)
              ..fillPath()
              ..moveTo(size.x, 0)
              ..lineTo(size.x, 230)
              ..lineTo(size.x - 60, 0)
              ..fillPath()
              ..setColor(green)
              ..moveTo(size.x, 0)
              ..lineTo(size.x, 100)
              ..lineTo(size.x - 100, 0)
              ..fillPath()
              ..setColor(lightGreen)
              ..moveTo(size.x - 30, 0)
              ..lineTo(size.x - 110, 50)
              ..lineTo(size.x - 150, 0)
              ..fillPath();
          },
        ),
      );
    },
  );
}

class UrlText extends StatelessWidget {
  UrlText(this.text, this.url);

  final String text;
  final String url;

  @override
  Widget build(Context context) {
    return UrlLink(
      destination: url,
      child: Text(text,
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: PdfColors.blue,
          )),
    );
  }
}
