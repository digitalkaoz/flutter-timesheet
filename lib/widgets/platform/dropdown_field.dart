import 'package:flutter/cupertino.dart' as c;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';

class Dropdown<T> extends StatelessWidget {
  final dynamic value;
  final List<DropdownMenuItem<T>> items;
  final String Function(T) validator;
  final dynamic Function(dynamic) onChange;
  final String placeholder;

  const Dropdown(
      {Key key,
      this.value,
      this.items,
      this.validator,
      this.placeholder,
      this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (context) => c.CupertinoButton(
        borderRadius: BorderRadius.zero,
        color: Colors.transparent,
        padding: c.EdgeInsets.symmetric(horizontal: 32),
        child: Text(
          value.toString(),
          style: TextStyle(color: accent(context)),
        ),
        onPressed: () => c.showCupertinoModalPopup(
          context: context,
          builder: (_) => Container(
            height: 200,
            child: Center(
              child: c.CupertinoPicker(
                useMagnifier: true,
                magnification: 1.5,
                itemExtent: 20,
                squeeze: 1,
                children: items,
                backgroundColor: Colors.white,
                onSelectedItemChanged: (int index) {
                  onChange(index);
                },
              ),
            ),
          ),
        ),
      ),
      android: (context) => DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          iconSize: 30,
          iconEnabledColor: fgInverted(context),
          value: value,
          isDense: true,
          onChanged: onChange,
          items: items,
        ),
      ),
    );
  }
}
