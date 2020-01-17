import 'package:shared_preferences/shared_preferences.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/timesheet.dart';

abstract class Storage {
  static const CLIENTS = 'clients';

  Future<List<Client>> load();

  Future<bool> setCurrentClient(Client client);

  Future<String> getCurrentClient();

  Future<bool> deleteClient(Client client);

  Future<bool> saveClient(Client client);

  Future<bool> saveTimesheet(Timesheet sheet);

  Future<Timesheet> loadTimesheet(String id) {}
}

class LocalStorage implements Storage {
  @override
  Future<bool> setCurrentClient(Client client) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString("current", client.id);
  }

  @override
  Future<String> getCurrentClient() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString("current");
  }

  @override
  Future<List<Client>> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //await prefs.clear();

    List<String> serializedClients = prefs.getStringList(Storage.CLIENTS);

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
  Future<Timesheet> loadTimesheet(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final serializedSheet = prefs.getString("timesheet_$id");
    if (serializedSheet == null) {
      return null;
    }
    return Timesheet.fromString(this, serializedSheet);
  }

  @override
  Future<bool> deleteClient(Client client) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final clients = prefs.getStringList(Storage.CLIENTS);

    if (clients == null) {
      return true;
    }

    clients.removeWhere((serializedClient) {
      final persistedClient = Client.fromString(this, serializedClient);
      if (persistedClient.id == client.id) {
        return true;
      }
      return false;
    });

    return prefs.setStringList(Storage.CLIENTS, clients);
  }

  @override
  Future<bool> saveClient(Client client) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var clients = prefs.getStringList(Storage.CLIENTS);

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

    return prefs.setStringList(Storage.CLIENTS, clients);
  }

  @override
  Future<bool> saveTimesheet(Timesheet sheet) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String key = 'timesheet_${sheet.id}';

    return prefs.setString(key, sheet.toJson());
  }
}
