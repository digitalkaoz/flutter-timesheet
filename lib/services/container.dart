import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/model/local_storage.dart';
import 'package:timesheet_flutter/services/fake_data.dart';

final List<SingleChildCloneableWidget> providers = [
  Provider<Storage>(create: (_) => LocalStorage()),
  ProxyProvider<Storage, Clients>(
      update: (_, storage, __) => fakeData(storage)),
  Provider<PanelController>(create: (_) => PanelController()),
];
