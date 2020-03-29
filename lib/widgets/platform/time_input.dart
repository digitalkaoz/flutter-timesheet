import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/platform/icon.dart';
import 'package:timesheet_flutter/widgets/platform/input.dart';

class TimeInput extends StatelessWidget {
  final TextEditingController controller;
  final InputDecoration decoration;
  final String Function(String) validator;
  final String placeholder;
  final bool autofocus;
  final TimeOfDay initial;
  final FocusNode focusNode;
  final Function(TimeOfDay) onChange;
  final DateFormat format;
  final bool plain;
  final InputBorder border;

  const TimeInput(
      {Key key,
      this.controller,
      this.decoration,
      this.validator,
      this.placeholder,
      this.autofocus = false,
      this.initial,
      this.focusNode,
      this.onChange,
      this.format,
      this.plain,
      this.border})
      : super(key: key);

  Widget getSuffix(BuildContext context) {
    return PlatformIcon(
      icon: Icon(Icons.date_range),
      onTap: () => _onTap(context),
    );
  }

  _onTap(BuildContext context) async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    TimeOfDay time = TimeOfDay.now();

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        final date = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            (initial ?? time).hour,
            (initial ?? time).minute);
        await showCupertinoModalPopup(
          context: context,
          builder: (_) => Container(
            height: 250,
            color: brightness(context) == Brightness.light
                ? CupertinoColors.white
                : CupertinoColors.black,
            child: GestureDetector(
              onTap: () => null,
              child: CupertinoDatePicker(
                initialDateTime: date,
                mode: CupertinoDatePickerMode.time,
                onDateTimeChanged: (DateTime newDate) {
                  time = TimeOfDay(hour: newDate.hour, minute: newDate.minute);
                  if (time != null) {
                    controller.text = timeFormat(time);
                  }
                },
              ),
            ),
          ),
        );
        break;
      default:
        time = await showTimePicker(
          context: context,
          builder: (BuildContext context, Widget child) {
            return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child,
            );
          },
          initialTime: initial ?? time,
        );

        if (time != null) {
          controller.text = timeFormat(time);
        }
    }

    if (onChange != null && time != null) {
      onChange(time);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Input(
      plain: plain,
      textStyle: textTheme(context),
      placeholder: placeholder,
      onTap: () => _onTap(context),
      focusNode: focusNode,
      controller: controller,
      validator: validator,
      autofocus: autofocus,
      border: border,
    );
  }
}
