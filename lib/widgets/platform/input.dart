import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';

const BorderSide _kDefaultRoundedBorderSide = BorderSide(
  color: CupertinoDynamicColor.withBrightness(
    color: Color(0x33000000),
    darkColor: Color(0x33FFFFFF),
  ),
  style: BorderStyle.solid,
  width: 0.0,
);
const Border _kDefaultRoundedBorder = Border(
  top: _kDefaultRoundedBorderSide,
  bottom: _kDefaultRoundedBorderSide,
  left: _kDefaultRoundedBorderSide,
  right: _kDefaultRoundedBorderSide,
);

const BoxDecoration _kDefaultRoundedBorderDecoration = BoxDecoration(
  color: CupertinoDynamicColor.withBrightness(
    color: CupertinoColors.white,
    darkColor: CupertinoColors.black,
  ),
  border: _kDefaultRoundedBorder,
  borderRadius: BorderRadius.all(Radius.circular(5.0)),
);

class Input extends StatelessWidget {
  final TextEditingController controller;
  final InputDecoration decoration;
  final String Function(String) validator;
  final TextInputType keyboardType;
  final bool obscure;
  final String placeholder;
  final bool autofocus;
  final FocusNode focusNode;
  final Function() onTap;
  final bool plain;
  final InputBorder border;
  final TextStyle textStyle;

  const Input({
    Key key,
    this.controller,
    this.decoration,
    this.validator,
    this.keyboardType,
    this.obscure = false,
    this.placeholder,
    this.autofocus = false,
    this.focusNode,
    this.onTap,
    this.plain = false,
    this.border,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (context) => CupertinoTextField(
        style: textThemeInverted(context),
        autofocus: autofocus,
        controller: controller,
        padding: EdgeInsets.symmetric(vertical: 8),
        prefix: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            placeholder ?? "",
            //style: textTheme(context).copyWith(color: fg(context)),
          ),
        ),
        onTap: onTap,
        focusNode: focusNode,
        decoration: plain
            ? BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: Colors.white,
              )
            : _kDefaultRoundedBorderDecoration,
        onChanged: validator,
        obscureText: obscure,
        //decoration: decoration,
        keyboardType: keyboardType,
      ),
      android: (_) => TextFormField(
        autofocus: autofocus,
        autovalidate: true,
        controller: controller,
        onTap: onTap,
        validator: validator,
        obscureText: obscure,
        style: textStyle ?? text(_).copyWith(color: Colors.white),
        focusNode: focusNode,
        keyboardType: keyboardType,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          labelText: placeholder,
        ).applyDefaults(Theme.of(_).inputDecorationTheme),
      ),
    );
  }
}
