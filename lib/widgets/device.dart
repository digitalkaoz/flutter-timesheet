import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

class DeviceWidget extends StatelessWidget {
  final Widget Function(BuildContext) web;
  final Widget Function(BuildContext) tablet;
  final Widget Function(BuildContext) phone;

  const DeviceWidget({Key key, this.web, this.tablet, this.phone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return web(context);
    }

    if (Device.get().isTablet) {
      return tablet(context);
    }

    return phone(context);
  }
}

final isWeb = kIsWeb;
final isTablet = Device.get().isTablet;
final isPhone = Device.get().isPhone;
