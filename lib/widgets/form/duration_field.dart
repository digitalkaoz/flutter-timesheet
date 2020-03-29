import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  _showDialog(BuildContext context, Duration value) async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    Duration duration = Duration(hours: 0, minutes: 0);

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        await showCupertinoModalPopup(
          context: context,
          builder: (_) => Container(
            height: 250,
            width: double.infinity,
            color: brightness(context) == Brightness.light
                ? CupertinoColors.white
                : CupertinoColors.black,
            child: GestureDetector(
              onTap: () => null,
              child: CupertinoTimerPicker(
                onTimerDurationChanged: (Duration pause) {
                  duration = pause;
                },
                initialTimerDuration: value ?? duration,
                minuteInterval: 5,
                mode: CupertinoTimerPickerMode.hm,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
        );
        break;
      default:
        duration = await showDurationPicker(
          context: context,
          snapToMins: 5.0,
          initialTime: value ?? duration,
        );
    }

    if (duration != null) {
      controller.text = durationFormat(duration);
      onChanged(duration);
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.text = durationFormat(value);

    return Input(
      controller: controller,
      textStyle: textTheme(context),
      plain: true,
      focusNode: NoKeyboardEditableTextFocusNode(),
      placeholder: hint,
      onTap: () async {
        await _showDialog(context, value);
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
