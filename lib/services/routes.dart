import 'package:flutter/cupertino.dart';
import 'package:timesheet_flutter/screens/index.dart';

Map<String, Widget Function(BuildContext context)> routes = {
  IndexScreen.ROUTE: (_) => IndexScreen()
};
