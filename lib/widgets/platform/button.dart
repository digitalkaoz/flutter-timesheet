import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as m
    show
        RaisedButton,
        FlatButton,
        IconButton,
        PopupMenuItem,
        PopupMenuButton,
        Offset;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';

final buttonBorderRadius = BorderRadius.circular(16);
const buttonPadding = EdgeInsets.symmetric(horizontal: 8.0);

class RaisedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final Function() onPressed;
  final String tooltip;
  final double padding;

  const RaisedButton(
      {Key key,
      this.color,
      this.onPressed,
      this.child,
      this.tooltip,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (context) => CupertinoButton(
        padding:
            padding != null ? EdgeInsets.symmetric(horizontal: padding) : null,
        borderRadius: buttonBorderRadius,
        color: onPressed == null ? fg(context) : accent(context),
        disabledColor: brightness(context) == Brightness.dark
            ? Colors.grey[600]
            : accent(context),
        child: child,
        onPressed: onPressed,
      ),
      android: (context) => m.RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: buttonBorderRadius),
        child: Padding(
          padding: buttonPadding,
          child: child,
        ),
        color: onPressed == null ? fg(context) : accent(context),
        onPressed: onPressed,
      ),
    );
  }
}

class Button extends StatelessWidget {
  final Widget child;
  final Color color;
  final Function() onPressed;

  const Button({Key key, this.color, this.onPressed, this.child})
      : super(key: key);

  ShapeBorder _shape(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
          color: color ?? brightness(context) == Brightness.dark
              ? Colors.transparent
              : Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (context) => CupertinoButton(
        child: child,
        onPressed: onPressed,
      ),
      android: (context) => m.FlatButton(
        shape: _shape(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: child,
        ),
        //color: color,
        onPressed: onPressed,
      ),
    );
  }
}

class IconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Function() onPressed;

  const IconButton({Key key, this.color, this.onPressed, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (context) => CupertinoButton(
        child: Icon(icon),
        onPressed: onPressed,
      ),
      android: (context) => m.IconButton(
        icon: Icon(
          icon,
          color: color,
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class MenuButton<T> extends StatelessWidget {
  final IconData icon;
  final Color color;
  final List<Map<String, dynamic>> items;

  const MenuButton({Key key, this.color, this.icon, this.items})
      : super(key: key);

  List<m.PopupMenuItem<T>> _androidItems(BuildContext context) {
    return items
        .map((item) => PopupMenuItem(
              child: Button(
                child: item["child"],
                onPressed: item["action"],
              ),
            ))
        .toList();
  }

  List<CupertinoActionSheetAction> _iosItems(BuildContext context) {
    return items
        .map((item) => CupertinoActionSheetAction(
              onPressed: item["action"],
              child: item["child"],
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (context) => CupertinoButton(
        child: Icon(
          icon,
          color: Colors.white,
        ),
        onPressed: () {
          showCupertinoModalPopup(
              context: context,
              builder: (BuildContext context) {
                return CupertinoActionSheet(
                  actions: _iosItems(context),
                  cancelButton: Button(
                    child: Text("Cancel"),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                );
              });
        },
      ),
      android: (context) => m.PopupMenuButton<T>(
        //offset: m.Offset.fromDirection(200, 80),
        icon: Icon(
          icon,
          color: color,
        ),
        itemBuilder: (BuildContext _) => _androidItems(_),
        onSelected: (_) => null,
      ),
    );
  }
}
