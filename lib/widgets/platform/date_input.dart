import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/platform/icon.dart';
import 'package:timesheet_flutter/widgets/platform/input.dart';

class DateInput extends StatelessWidget {
  final TextEditingController controller;
  final InputDecoration decoration;
  final String Function(String) validator;
  final String placeholder;
  final bool autofocus;
  final DateTime initial;
  final DateTime max;
  final DateTime min;
  final FocusNode focusNode;
  final Function(DateTime) onChange;
  final DateFormat format;
  final bool plain;
  final InputBorder border;

  const DateInput(
      {Key key,
      this.controller,
      this.decoration,
      this.validator,
      this.placeholder,
      this.autofocus = false,
      this.initial,
      this.max,
      this.min,
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

    DateTime date;

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        await showCupertinoModalPopup(
          context: context,
          builder: (_) => Container(
            height: 250,
            color: Theme.of(context).backgroundColor,
            child: GestureDetector(
              onTap: () => null,
              child: CupertinoDatePicker(
                initialDateTime: initial,
                mode: CupertinoDatePickerMode.date,
                maximumDate: max,
                minimumDate: min,
                onDateTimeChanged: (DateTime newDate) {
                  if (newDate != null) {
                    date = newDate;
                    String formatted = (this.format ??
                            DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY))
                        .format(newDate);
                    controller.text = formatted;
                  }
                },
              ),
            ),
          ),
        );
        break;
      default:
        date = await showDatePicker(
          context: context,
          initialDate: initial,
          firstDate: min,
          lastDate: max,
        );

        if (date != null) {
          controller.text =
              (this.format ?? DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY))
                  .format(date);
        }
    }

    if (onChange != null && date != null) {
      onChange(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Input(
      textStyle: textTheme(context),
      plain: plain,
      placeholder: placeholder,
      onTap: () => _onTap(context),
      border: border,
      focusNode: focusNode,
      controller: controller,
      validator: validator,
      autofocus: autofocus,
    );
  }
}
