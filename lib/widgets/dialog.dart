import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/platform/dialog_button.dart';
import 'package:timesheet_flutter/widgets/platform/input.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';

class CancelDialogButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DialogButton(
      color: fg(context),
      child: Text(
        'Cancel',
        style: textTheme(context)
            .copyWith(color: isIos ? accent(context) : fg(context)),
      ),
      onTap: () => Navigator.of(context).pop(),
    );
  }
}

class ConfirmDialogButton extends StatelessWidget {
  final String text;
  final Function onTap;

  const ConfirmDialogButton(
      {Key key, @required this.text, @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogButton(
      primary: true,
      color: accent(context),
      child: Text(
        text,
        style:
            textTheme(context).copyWith(color: isIos ? accent(context) : null),
      ),
      onTap: onTap,
    );
  }
}

class DialogTitle extends StatelessWidget {
  final String text;

  const DialogTitle({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: prettyTheme(context).copyWith(color: accent(context)),
    );
  }
}

class DialogInput extends StatelessWidget {
  final TextEditingController controller;
  final String Function(String) validator;
  final String placeholder;

  const DialogInput(
      {Key key,
      @required this.controller,
      @required this.validator,
      this.placeholder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Input(
          controller: controller,
          textStyle: textThemeInverted(context),
          autofocus: true,
          validator: validator,
          decoration: InputDecoration(
            hintText: placeholder,
          )),
    );
  }
}

showSuccess(BuildContext context, String message) {
  if (message == null) {
    return;
  }

  if (defaultTargetPlatform == TargetPlatform.android) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
