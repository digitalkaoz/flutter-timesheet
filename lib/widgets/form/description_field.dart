import 'package:flutter/material.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/platform/input.dart';

class DescriptionField extends StatelessWidget {
  final String value;
  final TextEditingController controller;
  final String hint;
  final Function(String value) onChanged;

  DescriptionField({
    Key key,
    @required this.onChanged,
    this.hint,
    @required this.controller,
    this.value,
  }) : super(key: key) {
    controller.text = value;
    controller.addListener(() => onChanged(controller.text));
  }

  @override
  Widget build(BuildContext context) {
    return Input(
      controller: controller,
      textStyle: textTheme(context),
      plain: true,
      focusNode: FocusNode(),
      autofocus: false,
      placeholder: "Description",
    );
  }
}
