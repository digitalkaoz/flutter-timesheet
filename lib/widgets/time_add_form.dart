import 'package:flutter/material.dart' hide RaisedButton;
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/model/time.dart';
import 'package:timesheet_flutter/model/timesheet.dart';
import 'package:timesheet_flutter/widgets/device.dart';
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
  final int columns;

  TimeAddForm({Key key, this.columns = 1, this.dense = false})
      : super(key: key);

  void _unfocus(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    FocusScope.of(context).requestFocus(FocusNode());
  }

  Widget _descriptionField(Time time) {
    return DescriptionField(
      value: time.description,
      controller: description,
      hint: "Description".padRight(20),
      onChanged: (String value) {
        time.description = value;
      },
    );
  }

  Widget _startField(Time time, BuildContext context) {
    return TimeField(
      value: time.start,
      controller: start,
      onChanged: (TimeOfDay value) {
        time.start = value;
        _unfocus(context);
      },
      hint: "Start".padRight(20),
    );
  }

  Widget _endField(Time time, BuildContext context) {
    return TimeField(
      value: time.end,
      controller: end,
      onChanged: (TimeOfDay value) {
        time.end = value;
        _unfocus(context);
      },
      hint: "End".padRight(20),
    );
  }

  Widget _durationField(Time time, BuildContext context) {
    return DurationField(
      controller: pause,
      value: time.pause,
      onChanged: (value) {
        time.pause = value;
        _unfocus(context);
      },
      hint: "Pause".padRight(20),
    );
  }

  Widget _dateField(Time time, BuildContext context) {
    return DateField(
      value: time.date,
      controller: date,
      onChanged: (DateTime value) {
        time.date = value;
        _unfocus(context);
      },
      hint: "Date".padRight(15),
    );
  }

  List<Widget> _singleColumn(Time time, BuildContext context) {
    final Widget spacer = SizedBox(height: dense ? 10 : 20);

    return [
      _descriptionField(time),
      spacer,
      _startField(time, context),
      spacer,
      _endField(time, context),
      spacer,
      _durationField(time, context),
      spacer,
      _dateField(time, context),
      spacer,
      _buttonBar(time, context)
    ];
  }

  List<Widget> _doubleColumn(Time time, BuildContext context) {
    final Widget spacer = SizedBox(height: dense ? 10 : 20);

    return [
      spacer,
      Container(
        height: 60,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(flex: 1, child: _dateField(time, context)),
            SizedBox(width: 16),
            Flexible(flex: 3, child: _descriptionField(time)),
          ],
        ),
      ),
      spacer,
      Container(
        height: 60,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(child: _startField(time, context)),
            SizedBox(width: 16),
            Flexible(child: _durationField(time, context)),
            SizedBox(width: 16),
            Flexible(child: _endField(time, context)),
          ],
        ),
      ),
      spacer,
      _buttonBar(time, context)
    ];
  }

  Widget _buttonBar(Time time, BuildContext context) {
    final PanelController sheet = Provider.of<PanelController>(context);
    final Client client = Provider.of<Clients>(context).current;
    final Timesheet timesheet = client.currentTimesheet;

    return ButtonBar(
      alignment: isTablet || isWeb
          ? MainAxisAlignment.center
          : MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        timesheet.isNewtime
            ? Container()
            : Button(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  // TODO restore initial time!
                  timesheet.setCurrentTime(Time());
                  try {
                    sheet.close();
                  } catch (e) {}
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
          child: Text(
            timesheet.isNewtime ? "Save" : "Update",
            style: TextStyle(
                color: time.valid
                    ? brightness(context) == Brightness.dark
                        ? Colors.black
                        : Colors.white
                    : Colors.grey[600]),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Client client = Provider.of<Clients>(context).current;

    return Observer(
      builder: (_) {
        if (client == null) {
          return Container();
        }
        final Timesheet timesheet = client.currentTimesheet;
        final Time time = timesheet.editableTime;

        return Container(
          color: bg(context),
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children:
                columns == 1 ? _singleColumn(time, _) : _doubleColumn(time, _),
          ),
        );
      },
    );
  }
}
