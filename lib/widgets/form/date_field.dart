import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timesheet_flutter/widgets/platform/date_input.dart';

import 'duration_field.dart';

class DateField extends StatelessWidget {
  final format = DateFormat('yyyy-MM-dd');
  final TextEditingController controller;
  final String hint;
  final Function(DateTime date) onChanged;
  final DateTime value;

  DateField({
    Key key,
    @required this.onChanged,
    this.hint,
    this.controller,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.text = format.format(value ?? DateTime.now());

    return DateInput(
      controller: controller,
      plain: true,
      border: InputBorder.none,
      format: format,
      focusNode: NoKeyboardEditableTextFocusNode(),
      placeholder: hint,
      min: DateTime.now().subtract(Duration(days: 600)),
      max: DateTime.now().add(Duration(days: 1)),
      initial: value ?? DateTime.now(),
      onChange: (date) => onChanged(date),
      validator: (value) {
        try {
          DateTime.parse(value);
          return null;
        } catch (e) {
          return 'invalid date';
        }
      },
    );
  }
}
