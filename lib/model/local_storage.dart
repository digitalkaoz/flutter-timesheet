import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/timesheet.dart';

abstract class Storage {
  Future<bool> setCurrentClient(Client client);

  Future<List<Client>> load();

  Future<bool> addClient(Client client);
  Future<bool> deleteClient(Client client);

  saveClient(Client client, [String oldName]) {}

  saveTimesheet(Timesheet sheet) {}
}

class LocalStorage implements Storage {
  @override
  Future<bool> setCurrentClient(Client client) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString("current", client.name);
  }

  @override
  Future<List<Client>> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return _loadClients(prefs);
  }

  List<Client> _loadClients(SharedPreferences prefs) {
    List<String> serializedClients = prefs.getStringList('clients');

    List<Client> clients = [];

    serializedClients.forEach((serializedClient) {
      Client client = Client.fromString(this, serializedClient);
      client.timesheets =
          ObservableList<Timesheet>.of(_loadTimesheets(prefs, client));

      clients.add(client);
    });

    return clients;
  }

  List<Timesheet> _loadTimesheets(SharedPreferences prefs, Client client) {
    List<String> serializedSheets =
        prefs.getStringList('timesheets_${client.name}');

    List<Timesheet> sheets = [];

    serializedSheets.forEach((serializedSheet) {
      sheets.add(Timesheet.fromString(this, serializedSheet));
    });

    return sheets;
  }

  @override
  Future<bool> addClient(Client client) {
    // TODO: implement addClient
    //throw UnimplementedError();
  }

  @override
  Future<bool> deleteClient(Client client) {
    // TODO: implement deleteClient
    //throw UnimplementedError();
  }

  @override
  saveClient(Client client, [String oldName]) {
    // TODO: implement saveClient
    //throw UnimplementedError();
  }

  @override
  saveTimesheet(Timesheet sheet) {
    // TODO: implement saveTimesheet
    //throw UnimplementedError();
  }
}
