import 'package:flutter/material.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:intl/intl.dart';

import '../../services/theme.dart';

class DurationField extends StatelessWidget {
  final format = DateFormat(DateFormat.HOUR_MINUTE);
  final Duration value;
  final TextEditingController controller;
  final String hint;
  final Function(Duration value) onChanged;

  DurationField({
    Key key,
    @required this.onChanged,
    this.hint,
    this.controller,
    this.value,
  }) : super(key: key);

  _showDialog(BuildContext context) async {
    final Duration duration = await showDurationPicker(
      context: context,
      snapToMins: 5.0,
      initialTime: Duration(hours: 0, minutes: 0),
    );

    if (duration != null) {
      controller.text = formatDuration(duration);
      onChanged(duration);
    }
  }

  static String formatDuration(Duration duration) {
    return duration.toString().split('.').first.padLeft(8, "0");
  }

  @override
  Widget build(BuildContext context) {
    controller.text = formatDuration(value ?? Duration());

    return TextFormField(
      controller: controller,
      focusNode: NoKeyboardEditableTextFocusNode(),
      decoration: invertedFormField.copyWith(hintText: hint),
      onTap: () async {
        await _showDialog(context);
      },
    );
  }
}

class NoKeyboardEditableTextFocusNode extends FocusNode {
  @override
  bool consumeKeyboardToken() {
    // prevents keyboard from showing on first focus
    return false;
  }
}
