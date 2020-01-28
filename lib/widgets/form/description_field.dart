import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timesheet_flutter/widgets/platform/input.dart';

class DescriptionField extends StatelessWidget {
  final format = DateFormat(DateFormat.HOUR_MINUTE);
  final String value;
  final TextEditingController controller;
  final String hint;
  final Function(String value) onChanged;

  DescriptionField({
    Key key,
    @required this.onChanged,
    this.hint,
    this.controller,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (value != null && value.isNotEmpty) {
      controller.text = value;
    }

    return Input(
      controller: controller,
      plain: true,
      border: InputBorder.none,
      placeholder: "Description",
    );
  }
}
