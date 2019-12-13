import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../services/theme.dart';

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
    controller.text = value;

    return TextFormField(
      controller: controller,
      decoration: invertedFormField.copyWith(
          hintText: hint, contentPadding: EdgeInsets.only(left: 10)),
    );
  }
}
