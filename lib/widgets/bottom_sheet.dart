import 'package:flutter/widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:timesheet_flutter/services/theme.dart';

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
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      color: defaultColor,
      minHeight: height,
      maxHeight: 550,
      controller: controller,
      collapsed: collapsed,
      backdropEnabled: true,
      parallaxEnabled: true,
      panel: panel,
      body: body,
    );
  }
}
