import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/device.dart';
import 'package:timesheet_flutter/widgets/platform/icon.dart';
import 'package:timesheet_flutter/widgets/platform/widget.dart';

class PlatformNavBar extends StatelessWidget
    implements PreferredSizeWidget, ObstructingPreferredSizeWidget {
  final Widget title;
  final Widget trailing;
  final Widget drawer;
  final Widget leading;

  const PlatformNavBar(
      {Key key, this.title, this.trailing, this.drawer, this.leading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = isTablet || isWeb
        ? (MediaQuery.of(context).size.width / 6) * 2
        : (MediaQuery.of(context).size.width / 3) * 2;

    return PlatformWidget(
      ios: (context) => CupertinoNavigationBar(
        backgroundColor: Colors.transparent,
        border: null,
        leading: leading ??
            PlatformIcon(
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  builder: (_) => Stack(
                    children: [
                      Positioned(
                        left: 0,
                        height: MediaQuery.of(_).size.height,
                        width: width,
                        child: drawer ?? Container(),
                      ),
                      Positioned(
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: PlatformIcon(
                            icon: Icon(
                              Icons.close,
                              color: brightness(context) == Brightness.dark
                                  ? accent(context)
                                  : Colors.white,
                            ),
                          ),
                        ),
                        left: width - 30,
                        top: 36,
                      ),
                    ],
                  ),
                );
              },
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
        middle: title,
        trailing: trailing,
      ),
      android: (context) => AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: leading,
        automaticallyImplyLeading: leading == null,
        centerTitle: true,
        title: title,
        actions: trailing == null ? [] : <Widget>[trailing],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return true;
  }
}
