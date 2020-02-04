import 'package:flutter/material.dart' hide RaisedButton;
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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

  void _unfocus(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    FocusScope.of(context).requestFocus(FocusNode());
  }

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
          color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              spacer,
              _invertedInput(
                _,
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
                _,
                TimeField(
                  value: time.start,
                  controller: start,
                  onChanged: (TimeOfDay value) {
                    time.start = value;
                    _unfocus(_);
                  },
                  hint: "Start".padRight(20),
                ),
              ),
              spacer,
              _invertedInput(
                _,
                TimeField(
                  value: time.end,
                  controller: end,
                  onChanged: (TimeOfDay value) {
                    time.end = value;
                    _unfocus(_);
                  },
                  hint: "End".padRight(20),
                ),
              ),
              spacer,
              _invertedInput(
                _,
                DurationField(
                  controller: pause,
                  value: time.pause,
                  onChanged: (value) {
                    time.pause = value;
                    _unfocus(_);
                  },
                  hint: "Pause".padRight(20),
                ),
              ),
              spacer,
              _invertedInput(
                _,
                DateField(
                  value: time.date,
                  controller: date,
                  onChanged: (DateTime value) {
                    time.date = value;
                    _unfocus(_);
                  },
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
                            sheet.close();
                          },
                        ),
                  RaisedButton(
                    color: Colors.white,
                    //disabledColor: defaultColor,
                    //disabledTextColor: Colors.white.withAlpha(75),
                    //textColor: defaultColor,
                    onPressed: time.valid
                        ? () {
                            timesheet.saveTime();
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

  Widget _invertedInput(BuildContext context, Widget widget) {
    return Container(
      decoration: invertedFormFieldWrapper(context),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: widget,
    );
  }
}
