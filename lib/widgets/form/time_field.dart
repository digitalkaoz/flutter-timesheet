import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timesheet_flutter/services/theme.dart';

import 'duration_field.dart';

class TimeField extends StatelessWidget {
  final format = DateFormat(DateFormat.HOUR24_MINUTE);
  final TimeOfDay value;
  final String hint;
  final Function(TimeOfDay time) onChanged;
  final TextEditingController controller;

  TimeField({
    Key key,
    @required this.onChanged,
    this.hint,
    this.value,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (value != null) {
      controller.text = timeFormat(value);
    }

    return TextFormField(
      controller: controller,
      focusNode: NoKeyboardEditableTextFocusNode(),
      decoration: invertedFormField.copyWith(hintText: hint),
      onTap: () async {
        await _showDialog(context);
      },
    );
  }

  _showDialog(BuildContext context) async {
    final TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: value ?? TimeOfDay.now(),
    );

    if (time != null) {
      onChanged(time);
    }
  }
}
