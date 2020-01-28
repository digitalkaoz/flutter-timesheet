import 'package:flutter/material.dart' hide RaisedButton;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/model/time.dart';
import 'package:timesheet_flutter/model/timesheet.dart';
import 'package:timesheet_flutter/widgets/form/date_field.dart';
import 'package:timesheet_flutter/widgets/form/description_field.dart';
import 'package:timesheet_flutter/widgets/form/duration_field.dart';
import 'package:timesheet_flutter/widgets/form/time_field.dart';
import 'package:timesheet_flutter/widgets/platform/button.dart';

import '../services/theme.dart';

class TimeAddForm extends StatelessWidget {
  final description = TextEditingController();
  final start = TextEditingController();
  final end = TextEditingController();
  final pause = TextEditingController();
  final date = TextEditingController();
  final bool dense;

  TimeAddForm({Key key, this.dense = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PanelController sheet = Provider.of<PanelController>(context);
    final Widget spacer = SizedBox(height: dense ? 10 : 20);
    return Observer(
      builder: (_) {
        final Client client = Provider.of<Clients>(context).current;

        if (client == null) {
          return Container();
        }
        final Timesheet timesheet = client.currentTimesheet;
        final Time time = timesheet.editableTime;

        return Container(
          color: defaultColor,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              spacer,
              _invertedInput(
                DescriptionField(
                  value: time.description,
                  controller: description,
                  hint: "Description".padRight(20),
                  onChanged: (String value) {
                    time.description = value;
                  },
                ),
              ),
              spacer,
              _invertedInput(
                TimeField(
                  value: time.start,
                  controller: start,
                  onChanged: (TimeOfDay value) {
                    time.start = value;
                  },
                  hint: "Start".padRight(20),
                ),
              ),
              spacer,
              _invertedInput(
                TimeField(
                  value: time.end,
                  controller: end,
                  onChanged: (TimeOfDay value) {
                    time.end = value;
                  },
                  hint: "End".padRight(20),
                ),
              ),
              spacer,
              _invertedInput(
                DurationField(
                  controller: pause,
                  value: time.pause,
                  onChanged: (value) {
                    time.pause = value;
                  },
                  hint: "Pause".padRight(20),
                ),
              ),
              spacer,
              _invertedInput(
                DateField(
                  value: time.date,
                  controller: date,
                  onChanged: (DateTime value) => time.date = value,
                  hint: "Date".padRight(15),
                ),
              ),
              spacer,
              ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  timesheet.isNewtime
                      ? Container()
                      : Button(
                          color: defaultColor,
                          child: Text("Cancel"),
                          onPressed: () {
                            timesheet.setCurrentTime(Time());
                            _clear(timesheet.editableTime, context);
                            sheet.close();
                          },
                        ),
                  RaisedButton(
                    color: defaultColor,
                    //disabledColor: defaultColor,
                    //disabledTextColor: Colors.white.withAlpha(75),
                    //textColor: defaultColor,
                    onPressed: time.valid
                        ? () {
                            timesheet.saveTime();

                            _clear(timesheet.editableTime, context);
                            try {
                              sheet.close();
                            } catch (e) {}
                          }
                        : null,
                    child: Text(timesheet.isNewtime ? "Save" : "Update"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  _clear(Time time, BuildContext context) {
    description.value = TextEditingValue(text: time.description);
    start.value = TextEditingValue(
        text: time.start != null ? time.start.format(context) : "");
    end.value = TextEditingValue(
        text: time.end != null ? time.end.format(context) : "");
    pause.value = TextEditingValue(
        text: time.pause != null ? durationFormat(time.pause) : "");
    date.value = TextEditingValue(
        text: DateFormat('yyyy-MM-dd').format(time.date ?? DateTime.now()));
  }

  Widget _invertedInput(Widget widget) {
    return Container(
      decoration: invertedFormFieldWrapper,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: widget,
    );
  }
}
