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
  final Color color;

  const Dropdown(
      {Key key,
      this.value,
      this.items,
      this.validator,
      this.placeholder,
      this.onChange,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (context) => c.CupertinoButton(
        borderRadius: BorderRadius.zero,
        color: this.color ?? fg(context),
        padding: c.EdgeInsets.symmetric(horizontal: 32),
        child: c.Row(
          mainAxisSize: c.MainAxisSize.max,
          mainAxisAlignment: c.MainAxisAlignment.center,
          children: <c.Widget>[
            Text(
              value.toString(),
              style: TextStyle(color: fgInverted(context)),
            ),
            Icon(Icons.arrow_drop_down)
          ],
        ),
        onPressed: () => c.showCupertinoModalPopup(
          context: context,
          builder: (_) => Container(
            height: 200,
            child: Center(
              child: c.CupertinoPicker(
                useMagnifier: true,
                magnification: 1.5,
                itemExtent: 22,
                squeeze: 1,
                children: items.map((i) => i.child).toList(),
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
