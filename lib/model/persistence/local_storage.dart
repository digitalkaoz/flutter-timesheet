import 'package:shared_preferences/shared_preferences.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/timesheet.dart';

abstract class Storage {
  List<Client> load();

  Future<bool> setCurrentClient(Client client);

  String getCurrentClient();

  Future<bool> deleteClient(Client client);

  Future<bool> saveClient(Client client);

  Future<bool> saveTimesheet(Timesheet sheet);

  Future<bool> deleteTimesheet(Timesheet sheet);

  Timesheet loadTimesheet(String id);
}

class LocalStorage implements Storage {
  static const CLIENTS = 'clients';
  static const CURRENT = 'current';

  final SharedPreferences prefs;

  LocalStorage(this.prefs);

  @override
  Future<bool> setCurrentClient(Client client) {
    return prefs.setString(CURRENT, client.id);
  }

  @override
  String getCurrentClient() {
    return prefs.getString(CURRENT);
  }

  @override
  List<Client> load() {
    //prefs.clear();
    List<String> serializedClients = prefs.getStringList(CLIENTS);
    List<Client> clients = [];

    if (serializedClients == null) {
      return clients;
    }

    serializedClients.forEach((serializedClient) {
      clients.add(Client.fromString(this, serializedClient));
    });

    return clients;
  }

  @override
  Timesheet loadTimesheet(String id) {
    final serializedSheet = prefs.getString("timesheet_$id");

    if (serializedSheet == null) {
      return null;
    }
    return Timesheet.fromString(this, serializedSheet);
  }

  @override
  Future<bool> deleteClient(Client client) async {
    final clients = prefs.getStringList(CLIENTS);

    if (clients == null) {
      return true;
    }

    await Future.wait(client.timesheets
        .map((t) => t != null ? deleteTimesheet(t) : Future.value(true))
        .toList());

    clients.removeWhere((serializedClient) {
      final persistedClient = Client.fromString(this, serializedClient);
      if (persistedClient.id == client.id) {
        return true;
      }
      return false;
    });

    return prefs.setStringList(CLIENTS, clients);
  }

  @override
  Future<bool> saveClient(Client client) async {
    var clients = prefs.getStringList(CLIENTS);

    if (clients == null) {
      clients = [];
    }

    clients.removeWhere((serializedClient) {
      final persistedClient = Client.fromString(this, serializedClient);
      if (persistedClient.id == client.id) {
        return true;
      }
      return false;
    });

    clients.add(client.toJson());

    return prefs.setStringList(CLIENTS, clients);
  }

  @override
  Future<bool> saveTimesheet(Timesheet sheet) {
    return prefs.setString('timesheet_${sheet.id}', sheet.toJson());
  }

  @override
  Future<bool> deleteTimesheet(Timesheet sheet) {
    return prefs.remove('timesheet_${sheet.id}');
  }
}
