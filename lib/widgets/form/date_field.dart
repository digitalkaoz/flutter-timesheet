import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../services/theme.dart';
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
    final DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 600)),
      lastDate: DateTime.now().add(Duration(days: 1)),
      initialDate: value ?? DateTime.now(),
    );

    if (date != null) {
      onChanged(date);
    }
  }
}
