import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future<T> showAlertDialog<T>(@required BuildContext context,
    @required Widget title, Widget content, @required List<Widget> actions) {
  switch (defaultTargetPlatform) {
    case TargetPlatform.iOS:
      return showCupertinoDialog<T>(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: title,
          content: content,
          actions: actions,
        ),
      );
    default:
      return showDialog<T>(
        context: context,
        builder: (_) => AlertDialog(
          title: title,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              content,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: actions,
              )
            ],
          ),
          //actions: actions,
        ),
      );
  }
}
