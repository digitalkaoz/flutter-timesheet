import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/services/fake_data.dart';

final providers = [
  Provider<Clients>.value(value: fakeData()),
  Provider<PanelController>.value(value: PanelController()),
];
