import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';

class SlidingBottomSheet extends StatelessWidget {
  final double height;
  final PanelController controller;
  final Widget panel;
  final Widget body;
  final Widget collapsed;

  const SlidingBottomSheet({
    Key key,
    this.height: 62,
    this.controller,
    @required this.panel,
    this.body,
    this.collapsed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      onPanelClosed: () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        FocusScope.of(context).requestFocus(FocusNode());
      },
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      color: fg(context),
      boxShadow: [],
      minHeight: height,
      maxHeight: isIos ? 450 : 480,
      controller: controller,
      collapsed: collapsed,
      backdropEnabled: true,
      parallaxEnabled: false,
      panel: panel,
      body: body,
    );
  }
}
