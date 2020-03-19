import 'dart:convert';
import 'dart:io';

import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/persistence/local_storage.dart';
import 'package:timesheet_flutter/model/timesheet.dart';

part 'clients.g.dart';

class Clients extends ClientsBase with _$Clients {
  Clients(storage) : super(storage);
}

abstract class ClientsBase with Store {
  final Storage storage;

  ClientsBase(this.storage);

  @observable
  ObservableList<Client> clients = ObservableList<Client>();

  @observable
  int currentIndex = 0;

  @computed
  bool get hasClients {
    return clients.isNotEmpty;
  }

  @computed
  Client get current {
    if (clients.isEmpty) {
      return null;
    }

    return clients.elementAt(currentIndex);
  }

  @computed
  String get currentTitle {
    if (current == null) {
      return 'Timesheet';
    }

    return current.name;
  }

  @action
  void load() {
    clients = ObservableList.of(storage.load());

    final String activeId = storage.getCurrentClient();
    if (activeId != null) {
      clients.forEach((client) {
        if (client.id == activeId) {
          currentIndex = clients.indexOf(client);
        }
      });
    }
  }

  @action
  void setCurrent(Client client) {
    currentIndex = clients.indexOf(client);

    autorun((_) async {
      await storage.setCurrentClient(client);
    });
  }

  @action
  void setCurrentIndex(int index) {
    final c = clients.elementAt(index);

    if (c != null) {
      setCurrent(clients.elementAt(index));
    }
  }

  @action
  void addClient(Client client) {
    clients.add(client);
    setCurrent(client);

    autorun((_) async {
      await storage.saveClient(client);
    });
  }

  @action
  void removeClient(Client client) {
    clients.remove(client);
    if (currentIndex != 0) {
      currentIndex = currentIndex - 1;
    }

    autorun((_) async {
      await storage.deleteClient(client);
      if (clients.isNotEmpty) {
        await storage.setCurrentClient(clients.elementAt(currentIndex));
      }
    });
  }

  String validateName(String value) {
    if (value.isEmpty) {
      return 'Client name can not be blank';
    }

    if (clients.isEmpty) {
      return null;
    }

    final Client client = clients.firstWhere(
        (Client client) => client.name == value,
        orElse: () => null);

    if (client != null) {
      return 'Client names must be unique';
    }

    return null;
  }

  Future<File> export() async {
    final directory = await getExternalStorageDirectory();
    final file = File('${directory.path}/timesheets.json');

    final export = {};

    clients.forEach((c) {
      export[c.id] = c.toMap();
      export[c.id]["sheets"] = c.timesheets.map((t) => t.toMap()).toList();
    });

    return file.writeAsString(jsonEncode(export));
  }

  import(File file) async {
    final data = await file.readAsString();
    final import = jsonDecode(data);

    await Future.wait(
        clients.map((c) async => await storage.deleteClient(c)).toList());
    clients.clear();

    import.forEach((k, v) {
      v['sheets'] = v['sheets'].map((sheet) {
        final t = Timesheet.fromMap(storage, sheet['id'], sheet);
        storage.saveTimesheet(t);
        return sheet['id'];
      });

      final c = Client.fromMap(storage, k, v);
      addClient(c);
    });
  }
}
