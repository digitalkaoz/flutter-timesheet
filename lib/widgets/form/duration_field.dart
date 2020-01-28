import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:intl/intl.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/platform/input.dart';

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
    Duration duration;

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        await showCupertinoModalPopup(
          context: context,
          builder: (_) => GestureDetector(
            onTap: () => null,
            child: CupertinoTimerPicker(
              onTimerDurationChanged: (Duration pause) {
                duration = pause;
              },
              initialTimerDuration: value,
              minuteInterval: 5,
              mode: CupertinoTimerPickerMode.hm,
              alignment: Alignment.bottomCenter,
            ),
          ),
        );
        break;
      default:
        duration = await showDurationPicker(
          context: context,
          snapToMins: 5.0,
          initialTime: Duration(hours: 0, minutes: 0),
        );
    }

    if (duration != null) {
      controller.text = durationFormat(duration);
      onChanged(duration);
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.text = durationFormat(value ?? Duration());

    return Input(
      controller: controller,
      plain: true,
      focusNode: NoKeyboardEditableTextFocusNode(),
      placeholder: hint,
      border: InputBorder.none,
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
