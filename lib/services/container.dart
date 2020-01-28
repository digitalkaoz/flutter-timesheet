import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/model/persistence/local_storage.dart';

final List<InheritedProvider> providers = [
  FutureProvider<SharedPreferences>(
    create: (_) => SharedPreferences.getInstance(),
  ),
  ProxyProvider<SharedPreferences, Storage>(
    update: (_, prefs, __) => LocalStorage(prefs),
  ),
  ProxyProvider<Storage, Clients>(
    update: (_, storage, __) => Clients(storage),
  ),
  Provider<PanelController>(create: (_) => PanelController()),
];

List<InheritedProvider> createProviders(SharedPreferences prefs) {
  return [
    Provider<Storage>(
      create: (_) => LocalStorage(prefs),
    ),
    ProxyProvider<Storage, Clients>(
      update: (_, storage, __) => Clients(storage),
    ),
    Provider<PanelController>(create: (_) => PanelController()),
  ];
}
